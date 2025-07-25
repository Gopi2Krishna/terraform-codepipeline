##Launch template outputs

output "lt-name" {
  value       = aws_launch_template.lt-1.name
  description = "Id of launch template"
}

output "lt-latest-version" {
  value       = aws_launch_template.lt-1.latest_version
  description = "latest version of the launch template"
}

##ASG outputs

output "asg-arn" {
  value       = aws_autoscaling_group.asg-1.arn
  description = "ARN of asg-1"
}

output "asg-name" {
  value       = aws_autoscaling_group.asg-1.name
  description = "id of asg-1"
}
