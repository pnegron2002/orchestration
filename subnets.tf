
# Subnet Submitted CIDR Range
# https://www.terraform.io/docs/configuration/functions/cidrsubnet.html


# Create 4 subnets to launch our instances into
resource "aws_subnet" "public_sub1" {
  vpc_id                            = aws_vpc.netops_vpc.id
  availability_zone                 = "${var.aws_region}a"
  cidr_block                        = local.public_a
  tags = {
    Name                            = "${local.resource_name}PublicA"
    Tenant                          = title(var.tenant)
    Type                            = title(var.type)
    Environment                     = title(var.environ)
  }
}
resource "aws_subnet" "public_sub2" {
  vpc_id                            = aws_vpc.netops_vpc.id
  availability_zone                 = "${var.aws_region}b"
  cidr_block                        = local.public_b
  tags = {
    Name                            = "${local.resource_name}PublicB"
    Tenant                          = title(var.tenant)
    Type                            = title(var.type)
    Environment                     = title(var.environ)
  }
}
resource "aws_subnet" "private_sub1" {
  vpc_id                            = aws_vpc.netops_vpc.id
  availability_zone                 = "${var.aws_region}a"
  cidr_block                        = local.private_a
  tags = {
    Name                            = "${local.resource_name}PrivateA"
    Tenant                          = title(var.tenant)
    Type                            = title(var.type)
    Environment                     = title(var.environ)
  }
}
resource "aws_subnet" "private_sub2" {
  vpc_id                            = aws_vpc.netops_vpc.id
  availability_zone                 = "${var.aws_region}b"
  cidr_block                        = local.private_b
  tags = {
    Name                            = "${local.resource_name}PrivateB"
    Tenant                          = title(var.tenant)
    Type                            = title(var.type)
    Environment                     = title(var.environ)
  }
}

