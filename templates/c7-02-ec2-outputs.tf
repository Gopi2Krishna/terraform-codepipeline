#bastion ec2 outputs

output "bastion_id" {
  value = module.ec2-bastion.id
}

output "bastion_ip" {
  value = module.ec2-bastion.public_ip
}

#private ec2 outputs

output "private_ops" {
  value = { for instance in module.ec2-private : instance.id => instance.private_ip }
}

output "app3_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value       = [for i in module.ec2-db : i.id]
}
