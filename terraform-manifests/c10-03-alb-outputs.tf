# Outputs for ALB resources including ID, ARN, listeners, and DNS name
# Sensitive outputs are marked for security

# Terraform AWS Application Load Balancer (ALB) Outputs
output "alb_id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.id
}

output "alb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}
output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = { for k, v in module.alb.target_groups : k => v.id }
}

output "zone_id" {
  description = "zone id of alb"
  value       = module.alb.zone_id
}

output "dns_name" {
  description = "dns name"
  value       = module.alb.dns_name
}
