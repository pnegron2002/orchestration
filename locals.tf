locals {
resource_name                       = format("%s%s%s", title("${var.tenant}"), title("${var.type}"), title("${var.environ}"))
public_a                            = cidrsubnet("${var.env_cidr}", 2, 0)
public_b                            = cidrsubnet("${var.env_cidr}", 2, 1)
private_a                           = cidrsubnet("${var.env_cidr}", 2, 2)
private_b                           = cidrsubnet("${var.env_cidr}", 2, 3)
}
