resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.common_tags, {
    "Name"                                              = "${var.project_name}-vpc",
    "kubernetes.io/cluster/${var.project_name}-cluster" = "shared"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    "Name"                                              = "${var.project_name}-public-subnet-${count.index + 1}",
    "kubernetes.io/cluster/${var.project_name}-cluster" = "shared",
    "kubernetes.io/role/elb"                            = "1"
  })
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidrs)
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(var.common_tags, {
    "Name"                                              = "${var.project_name}-private-subnet-${count.index + 1}",
    "kubernetes.io/cluster/${var.project_name}-cluster" = "shared",
    "kubernetes.io/role/internal-elb"                   = "1"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-igw"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-public-rt"
  })
}

resource "aws_route_table_association" "public_rt_association" {
  route_table_id = aws_route_table.public_rt.id
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_eip" "nat_eip" {

  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-nat-eip"
  })
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-nat-gateway"
  })
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge(var.common_tags, {
    "Name" = "${var.project_name}-private-rt"
  })
}

resource "aws_route_table_association" "private_rt_association" {
  route_table_id = aws_route_table.private_rt.id
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
}
