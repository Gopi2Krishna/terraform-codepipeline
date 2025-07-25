resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2-bastion, module.vpc]
  instance   = module.ec2-bastion.id
  domain     = "vpc"
  tags       = local.tags

  provisioner "local-exec" {
    when        = destroy
    command     = "echo Destroy time `date` >> destroy.txt"
    working_dir = "local-exec-files/"
  }
}
