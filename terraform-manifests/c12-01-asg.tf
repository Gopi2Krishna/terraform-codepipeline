# Configures an Auto Scaling Group (ASG) with desired capacity and subnets
# Associates the ASG with target groups and health checks
# Includes instance refresh settings and tags for resource identification

# Autoscaling Group Resource
resource "aws_autoscaling_group" "asg-1" {
  name                = "${local.name}-asg"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  vpc_zone_identifier = module.vpc.private_subnets #all the private subnets--complements azs
  target_group_arns   = [module.alb.target_groups["tg1"].arn]
  health_check_type   = "EC2"
  #health_check_grace_period = 300 # default is 300 seconds  
  # Launch Template
  launch_template {
    id      = aws_launch_template.lt-1.id
    version = aws_launch_template.lt-1.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      #instance_warmup = 300 # Default behavior is to use the Auto Scaling Group's health check grace period.
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"] # You can add any argument from ASG here,
    #if those has changes, ASG Instance Refresh will trigger
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}
