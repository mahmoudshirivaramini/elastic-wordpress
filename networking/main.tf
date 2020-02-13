data "aws_availability_zones" "available" {}

resource "aws_vpc" "ewp_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  enable_classiclink   = "false"

  tags = {
    Name = "ewp_vpc"
  }
}


resource "aws_internet_gateway" "ewp_internet_gateway" {
  vpc_id = aws_vpc.ewp_vpc.id

  tags = {
    Name = "ewp_igw"
  }
}


resource "aws_eip" "nat" {
  vpc = true
}


resource "aws_nat_gateway" "ewp_natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.ewp_DMZPublic_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.ewp_internet_gateway]
}


resource "aws_route_table" "ewp_DMZPublic_rt" {
  vpc_id = aws_vpc.ewp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ewp_internet_gateway.id
  }
  tags = {
    Name = "ewp_DMZPublic"
  }
}


resource "aws_subnet" "ewp_DMZPublic_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.ewp_vpc.id
  cidr_block              = var.DMZPublic_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "ewp_DMZPublic_${count.index + 1}"
  }
}


resource "aws_route_table_association" "ewp_DMZPublic_assoc" {
  count          = length(aws_subnet.ewp_DMZPublic_subnet)
  subnet_id      = aws_subnet.ewp_DMZPublic_subnet.*.id[count.index]
  route_table_id = aws_route_table.ewp_DMZPublic_rt.id
}


resource "aws_route_table" "ewp_AppLayerPrivate_rt" {
  vpc_id = aws_vpc.ewp_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ewp_natgw.id
  }

  tags = {
    Name = "ewp_AppLayerPrivate"
  }
}


resource "aws_subnet" "ewp_AppLayerPrivate_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.ewp_vpc.id
  cidr_block              = var.AppLayerPrivate_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "ewp_AppLayerPrivate_${count.index + 1}"
  }
}


resource "aws_route_table_association" "ewp_AppLayerPrivate_assoc" {
  count          = length(aws_subnet.ewp_AppLayerPrivate_subnet)
  subnet_id      = aws_subnet.ewp_AppLayerPrivate_subnet.*.id[count.index]
  route_table_id = aws_route_table.ewp_AppLayerPrivate_rt.id
  depends_on    = [aws_nat_gateway.ewp_natgw]
}


resource "aws_route_table" "ewp_DBLayerPrivate_rt" {
  vpc_id = aws_vpc.ewp_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ewp_natgw.id
  }

  tags = {
    Name = "ewp_DBLayerPrivate"
  }
}


resource "aws_subnet" "ewp_DBLayerPrivate_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.ewp_vpc.id
  cidr_block              = var.DBLayerPrivate_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "ewp_DBLayerPrivate_${count.index + 1}"
  }
}


resource "aws_route_table_association" "ewp_DBLayerPrivate_assoc" {
  count          = length(aws_subnet.ewp_DBLayerPrivate_subnet)
  subnet_id      = aws_subnet.ewp_DBLayerPrivate_subnet.*.id[count.index]
  route_table_id = aws_route_table.ewp_DBLayerPrivate_rt.id
  depends_on    = [aws_nat_gateway.ewp_natgw]
}