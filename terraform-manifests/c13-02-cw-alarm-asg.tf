resource "aws_autoscaling_policy" "high-cpu-simple-scaling" {
  depends_on             = [aws_autoscaling_group.asg-1]
  autoscaling_group_name = aws_autoscaling_group.asg-1.name
  name                   = "${local.name}-cw-asg-scaling"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "asg-cpu-alarm" {
  depends_on          = [aws_autoscaling_policy.high-cpu-simple-scaling]
  alarm_name          = "${local.name}-asg-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg-1.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization and triggers the ASG Scaling policy to scale-out if CPU is above 80%"

  ok_actions = [aws_sns_topic.asg-sns-topic.arn]
  alarm_actions = [
    aws_autoscaling_policy.high-cpu-simple-scaling.arn,
    aws_sns_topic.asg-sns-topic.arn
  ]
}
