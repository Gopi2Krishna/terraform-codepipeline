#Local variables for internal use.

locals {
  Owner       = var.department
  environment = var.environment
  name        = "${local.Owner}-${local.environment}"

  tags = {
    Owner = "Gopi"
    env   = local.environment
  }
}

