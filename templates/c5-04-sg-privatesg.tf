module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"
  vpc_id  = module.vpc.vpc_id
  name    = "private-sg"
  #ingress rules
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  #egress rules
  egress_rules = ["all-all"]

  tags = local.tags
}

