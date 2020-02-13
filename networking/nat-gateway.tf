resource "aws_eip" "nat" {
  vpc = true
  tags = {
      Name = "NatGatewayIP"
  }
}

resource "aws_nat_gateway" "ewp_natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.ewp_DMZPublic_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.ewp_internet_gateway]
}