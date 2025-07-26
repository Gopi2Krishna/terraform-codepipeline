#bastion ec2 outputs

output "bastion_id" {
  value = module.ec2-bastion.id
}

output "bastion_ip" {
  value = module.ec2-bastion.public_ip
}



