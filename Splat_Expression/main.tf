resource "aws_vpc" "mainvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.mainvpc.id
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "demo-vpc-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "demovpcigw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name = "demo-vpc-IGW"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demovpcigw.id
  }
  tags = {
    Name = "demo-vpc-public-rt"
  }
}

resource "aws_route_table_association" "publicrtassociation" {
  count          = length(var.public_subnet_cidrs)
  route_table_id = aws_route_table.publicrt.id
  #subnet_id      = aws_subnet.public_subnets[count.index].id
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index) # This is called Splat Expression.
}

output "public_subnets" {
  value = aws_subnet.public_subnets
}

/*
Note:
===================================================================================================
# we can't use splat expression for map 
# we can use splat expression for list only
*/