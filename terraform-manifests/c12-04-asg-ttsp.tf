#target tracking policy
resource "aws_autoscaling_policy" "asg-cpu-avg-tracker" {
  name                      = "${local.name}-asg-cpu-avg-tracker"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.asg-1.id
  estimated_instance_warmup = 180 # defaults to ASG default cooldown 300 seconds if not set
  # CPU Utilization above 50
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

}

# TTS - Scaling Policy-2: Based on ALB Target Requests
resource "aws_autoscaling_policy" "alb-requests-tracker" {
  name                      = "${local.name}-alb-requests-tracker"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.asg-1.id
  estimated_instance_warmup = 120 # defaults to ASG default cooldown 300 seconds if not set  
  # Number of requests > 10 completed per target in an Application Load Balancer target group.
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["tg1"].arn_suffix}"
    }
    target_value = 10.0
  }
}
