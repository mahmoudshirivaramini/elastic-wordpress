resource "aws_internet_gateway" "ewp_internet_gateway" {
  vpc_id = aws_vpc.ewp_vpc.id

  tags = {
    Name = "ewp_igw"
  }
}