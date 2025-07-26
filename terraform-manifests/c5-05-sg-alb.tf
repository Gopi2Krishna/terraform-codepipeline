module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"
  vpc_id  = module.vpc.vpc_id
  name    = "${local.name}-loadbalancer-sg"

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  tags         = local.tags

  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      cidr_blocks = "0.0.0.0/0"
      protocol    = 6
      description = "allow 81 from internet"
    }
  ]
}
