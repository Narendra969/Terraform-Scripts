resource "aws_vpc" "demovpc" {
  cidr_block           = var.vpccidr
  instance_tenancy     = "default"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = "true"

  tags = merge(var.commontags, {
    "Name" = "demovpc"
  })
}

resource "aws_subnet" "demovpcpublicsubnets" {
  vpc_id                  = aws_vpc.demovpc.id
  count                   = length(var.publicsubnetscidrs)
  cidr_block              = element(var.publicsubnetscidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.commontags, {
    "Name" = "demovpc-publicsubnet-${count.index + 1}"
  })
}

resource "aws_subnet" "demovpcprivatesubnets" {
  vpc_id            = aws_vpc.demovpc.id
  count             = length(var.privatesubnetscidrs)
  cidr_block        = element(var.privatesubnetscidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(var.commontags, {
    "Name" = "demovpc-privatesubnet-${count.index + 1}"
  })
}

resource "aws_internet_gateway" "demovpcigw" {
  vpc_id = aws_vpc.demovpc.id

  tags = merge(var.commontags, {
    "Name" = "demovpc-igw"
  })
}


resource "aws_route_table" "demovpcpublicrt" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demovpcigw.id
  }

  tags = merge(var.commontags, {
    "Name" = "demovpc-publicrt"
  })
}

resource "aws_route_table_association" "demovpcigwpublicrtassociation" {
  count = length(var.publicsubnetscidrs)
  # subnet_id      = element(aws_subnet.demovpcpublicsubnets[*].id, count.index)  # or
  subnet_id      = aws_subnet.demovpcpublicsubnets[count.index].id
  route_table_id = aws_route_table.demovpcpublicrt.id
}

resource "aws_eip" "nateips" {
  count = length(var.publicsubnetscidrs)

  tags = merge(var.commontags, {
    "Name" = "Elastic-IP-${count.index + 1}"
  })
}

resource "aws_nat_gateway" "demovpcnatgateways" {
  count         = length(var.publicsubnetscidrs)
  allocation_id = aws_eip.nateips[count.index].id
  subnet_id     = aws_subnet.demovpcpublicsubnets[count.index].id
  depends_on    = [aws_internet_gateway.demovpcigw]

  tags = merge(var.commontags, {
    "Name" = "demovpc-NAT-${count.index + 1}"
  })
}

resource "aws_route_table" "demovpcprivaterts" {
  vpc_id = aws_vpc.demovpc.id
  count  = length(var.privatesubnetscidrs)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demovpcnatgateways[count.index].id
  }

  tags = merge(var.commontags, {
    "Name" = "demovpc-privatert-${count.index + 1}"
  })
}

resource "aws_route_table_association" "demovpcnatrtassociation" {
  count          = length(var.privatesubnetscidrs)
  subnet_id      = aws_subnet.demovpcprivatesubnets[count.index].id
  route_table_id = aws_route_table.demovpcprivaterts[count.index].id
}

/*
# suppose if we are trying to use same terraform configurations with different values for reusing
or creating multiple environments then we should use workaspace or remote backend concepts otherwise
same state file is modified accordind to the values.

# Terraform Workspace:
---------------------
$ terraform workspace show : It will show the name of the current workspace

$ terraform workspace list: list the workspaces

$ terraform workspace new <workspacename>: It will create the new workspace
ex:
$ terraform workspace new test : It will create test workspace

$ terraform workspace select <workspacename>: It will select the particular workspace 
ex:
$ terraform workspace select test : it will switched to test workspace

$ terraform workspace delete <workspacename>: It will delete the workspace
ex:
$ terraform workspace delete test: It will delete the test workspace
For deleting workspace first destroy the resources in that workspace and switch back to default 
workspace then we can delete that particular workspace.

Note:
---------------------------------------------------------------------------------------------------
** Terraform itself not recommonding to use terraform workspace concept, terraform recommonded to 
use remote backend concept.
---------------------------------------------------------------------------------------------------
# For Dev Environment:
----------------------
$ terraform workspace select dev
$ terraform plan -var-file="dev.tfvars"
$ terraform apply -var-file="dev.tfvars" -auto-approve
then state file is created in below directory
.
|-terraform.tfstate.d
  |-dev
    |-terraform.tfstate
    |-terraform.tfstate.backup

# For Prod Environment:
-----------------------
$ terraform workspace select prod
$ terraform plan -var-file="prod.tfvars"
$ terraform apply -var-file="prod.tfvars" -auto-approve
then state file is created in below directory
.
|-terraform.tfstate.d
  |-prod
    |-terraform.tfstate
    |-terraform.tfstate.backup
*/