terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "terraformprofile"
}

resource "aws_vpc" "demovpc" {
  cidr_block           = "192.168.0.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "demovpc"
  }
}

resource "aws_subnet" "publicsubnet1a" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "192.168.0.0/26"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "demovpc-publicsubnet-1a"
  }
}

resource "aws_subnet" "privatesubnet1a" {
  vpc_id            = aws_vpc.demovpc.id
  cidr_block        = "192.168.0.64/26"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "demovpc-privatesubnet-1a"
  }
}

resource "aws_subnet" "publicsubnet1b" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "192.168.0.128/26"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "demovpc-publicsubnet-1b"
  }
}

resource "aws_subnet" "privatesubnet1b" {
  vpc_id            = aws_vpc.demovpc.id
  cidr_block        = "192.168.0.192/26"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "demovpc-privatesubnet-1b"
  }
}

resource "aws_internet_gateway" "demovpcigw" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "demovpc-igw"
  }
}

resource "aws_route_table" "demovpcpublicrt" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demovpcigw.id
  }

  tags = {
    Name = "demovpc-publicrt"
  }
}

resource "aws_route_table_association" "demovpcigwrtassociation-1a" {
  subnet_id      = aws_subnet.publicsubnet1a.id
  route_table_id = aws_route_table.demovpcpublicrt.id
}

resource "aws_route_table_association" "demovpcigwrtassociation-1b" {
  subnet_id      = aws_subnet.publicsubnet1b.id
  route_table_id = aws_route_table.demovpcpublicrt.id
}

resource "aws_eip" "eipone" {
  #vpc = "true"

  tags = {
    Name = "ElasticNat-1a"
  }
}

resource "aws_nat_gateway" "demovpcnat-1a" {
  allocation_id = aws_eip.eipone.id
  subnet_id     = aws_subnet.publicsubnet1a.id

  tags = {
    Name = "NATGateWay-1a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.demovpcigw]
}

resource "aws_eip" "eiptwo" {
  # vpc = "true"

  tags = {
    Name = "ElasticNat-1b"
  }
}

resource "aws_nat_gateway" "demovpcnat-1b" {
  allocation_id = aws_eip.eiptwo.id
  subnet_id     = aws_subnet.publicsubnet1b.id

  tags = {
    Name = "NATGateWay-1b"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.demovpcigw]
}

resource "aws_route_table" "privateroutetable-1a" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demovpcnat-1a.id
  }

  tags = {
    Name = "demovpc-private-1a"
  }
}

resource "aws_route_table_association" "demovpcnatrtassociation-1a" {
  subnet_id      = aws_subnet.privatesubnet1a.id
  route_table_id = aws_route_table.privateroutetable-1a.id
}

resource "aws_route_table" "privateroutetable-1b" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demovpcnat-1b.id
  }

  tags = {
    Name = "demovpc-private-1b"
  }
}

resource "aws_route_table_association" "demovpcnatrtassociation-1b" {
  subnet_id      = aws_subnet.privatesubnet1b.id
  route_table_id = aws_route_table.privateroutetable-1b.id
}

/*
resource "aws_network_acl" "publicnacl" {
  vpc_id = aws_vpc.demovpc.id

  egress {
    rule_no    = 100
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "122.50.206.108/32"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    rule_no    = 400
    from_port  = 0
    to_port    = 0
    protocol   = "icmp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "Public-NACL"
  }
}

resource "aws_network_acl_association" "publicsubnet-1a-nacl-association" {
  network_acl_id = aws_network_acl.publicnacl.id
  subnet_id      = aws_subnet.publicsubnet1a.id
}

resource "aws_network_acl_association" "publicsubnet-1b-nacl-association" {
  network_acl_id = aws_network_acl.publicnacl.id
  subnet_id      = aws_subnet.publicsubnet1b.id
}
*/