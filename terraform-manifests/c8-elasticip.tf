resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2-bastion, module.vpc]
  instance   = module.ec2-bastion.id
  domain     = "vpc"
  tags       = local.tags
}
