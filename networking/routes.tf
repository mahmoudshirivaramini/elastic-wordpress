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

resource "aws_route_table_association" "ewp_DBLayerPrivate_assoc" {
  count          = length(aws_subnet.ewp_DBLayerPrivate_subnet)
  subnet_id      = aws_subnet.ewp_DBLayerPrivate_subnet.*.id[count.index]
  route_table_id = aws_route_table.ewp_DBLayerPrivate_rt.id
  depends_on    = [aws_nat_gateway.ewp_natgw]
}