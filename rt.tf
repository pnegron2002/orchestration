# Route Table Builds
resource "aws_route_table" "public_rt1" {
  vpc_id = aws_vpc.netops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netops_igw.id
  }
  tags = {
    Name = "NetopsDevPublicRt1"
  }
}
resource "aws_route_table" "public_rt2" {
  vpc_id = aws_vpc.netops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netops_igw.id
  }
  tags = {
    Name = "NetopsDevPublicRt2"
  }
}
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.netops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "NetopsDevPrivateRt1"
  }
}
resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.netops_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "NetopsDevPrivateRt2"
  }
}

# Associate the 3 subnets to the 3 local public routing tables

resource "aws_route_table_association" "custa_attach" {
  subnet_id      = aws_subnet.private_sub1.id
  route_table_id = aws_route_table.private_rt1.id
  }
resource "aws_route_table_association" "custb_attach" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.private_rt2.id
}
resource "aws_route_table_association" "shared_attach1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public_rt1.id
}
resource "aws_route_table_association" "shared_attach2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.public_rt2.id
}