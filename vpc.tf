variable aws_region { }
variable tenant { }
variable type { }
variable environ { }
variable env_cidr { }

provider "aws" {
  region                            = var.aws_region
  profile                           = "default"
}

# Create Transit VPC
resource "aws_vpc" "netops_vpc" {
  cidr_block                        = var.env_cidr
  tags = {
    Name                            = "${local.resource_name}Vpc"
    Tenant                          = title(var.tenant)
    Type                            = title(var.type)
    Environment                     = title(var.environ)

  }
}