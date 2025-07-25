#SNS topic
resource "aws_sns_topic" "asg-sns-topic" {
  name = "${local.name}-asg-sns-topic"
}

#SNS subscription
resource "aws_sns_topic_subscription" "asg-sns-sub" {
  topic_arn = aws_sns_topic.asg-sns-topic.arn
  protocol  = "email"
  endpoint  = "sunnysunny1708281@gmail.com"
}

resource "aws_autoscaling_notification" "asg-notification" {
  group_names = [aws_autoscaling_group.asg-1.id]
  topic_arn   = aws_sns_topic.asg-sns-topic.arn
  notifications = ["autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
  "autoscaling:EC2_INSTANCE_TERMINATE_ERROR", ]
}
