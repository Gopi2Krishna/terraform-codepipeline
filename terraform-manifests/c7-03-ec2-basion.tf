module "ec2-bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name          = "${local.name}-bastion"
  ami           = data.aws_ami.amznlnx.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion-sg.security_group_id]
  user_data              = file("${path.module}/app1-install.sh")
  tags                   = local.tags
}
