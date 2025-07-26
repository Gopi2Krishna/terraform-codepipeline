resource "aws_autoscaling_schedule" "increase-capacity" {
  scheduled_action_name  = "increase-capacity"
  autoscaling_group_name = aws_autoscaling_group.asg-1.name
  min_size               = 2
  max_size               = 10
  desired_capacity       = 5
  start_time             = "2025-12-22T00:00:00Z"
  recurrence             = "00 09 * * * "
}

resource "aws_autoscaling_schedule" "decrease-capacity" {
  scheduled_action_name  = "decrease-capacity"
  autoscaling_group_name = aws_autoscaling_group.asg-1.name
  time_zone              = "Asia/Kolkata"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  start_time             = "2025-12-23T00:00:00Z"
  recurrence             = "00 21 * * * "
}
