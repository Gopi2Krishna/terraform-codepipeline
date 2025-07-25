module "bastion-sg" {
    source  = "terraform-aws-modules/security-group/aws"
    version = "5.3.0"
    vpc_id = module.vpc.vpc_id
    name = "bastion-sg"
    #ingress rules
    ingress_rules = ["ssh-tcp"]
    ingress_cidr_blocks = ["0.0.0.0/0"]
    #egress_rules
    egress_rules = ["all-all"]
    
    tags = local.tags
}

