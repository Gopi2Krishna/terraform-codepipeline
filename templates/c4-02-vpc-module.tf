
#VPC module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name                               = "${local.name}-${var.vpc_name}"
  cidr                               = var.vpc_cidr
  azs                                = var.azs
  public_subnets                     = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets                    = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 2)]
  database_subnets                   = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  tags     = local.tags
  vpc_tags = local.tags

  public_subnet_tags = {
    Type = "Public Subnets"
  }
  private_subnet_tags = {
    Type = "Private Subnets"
  }
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }

}
