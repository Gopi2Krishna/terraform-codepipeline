resource "aws_cloudwatch_log_group" "cis-alarm-logs" {
  name = "${local.name}-cis-log-group"
}

module "cloudwatch_cis-alarms" {
  source            = "terraform-aws-modules/cloudwatch/aws//modules/cis-alarms"
  version           = "5.7.1"
  disabled_controls = ["DisableOrDeleteCMK", "VPCChanges"]

  log_group_name = aws_cloudwatch_log_group.cis-alarm-logs.name
  alarm_actions  = [aws_sns_topic.asg-sns-topic.arn]
}
