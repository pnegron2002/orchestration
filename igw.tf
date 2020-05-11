# Create Internet Gateway
resource "aws_internet_gateway" "netops_igw" {
  vpc_id = aws_vpc.netops_vpc.id
  tags = {
    Name = "${local.resource_name}Igw"
  }
}
# Create an Elastic IP

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public_sub1.id

  tags = {
    Name = "NetOps_Ngw"
  }
}
