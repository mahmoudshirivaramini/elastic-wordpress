data "aws_availability_zones" "available" {}

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