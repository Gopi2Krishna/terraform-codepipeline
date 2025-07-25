# VPC module configuration using the terraform-aws-modules/vpc/aws module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  # Name of the VPC, combining local name and variable vpc_name
  name = "${local.name}-${var.vpc_name}"

  # CIDR block for the VPC
  cidr = var.vpc_cidr

  # Availability zones for the VPC
  azs = var.azs

  # Public subnets, calculated using cidrsubnet function
  public_subnets = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k)]

  # Private subnets, calculated using cidrsubnet function
  private_subnets = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 2)]

  # Enable DNS hostnames and support in the VPC
  enable_dns_hostnames = true
  enable_dns_support   = true

  # NAT Gateway configuration
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  # Tags for the VPC and its resources
  tags     = local.tags
  vpc_tags = local.tags

  # Tags for public subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }

  # Tags for private subnets
  private_subnet_tags = {
    Type = "Private Subnets"
  }
}
