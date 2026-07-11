output "dashboard_name" {
  value = aws_cloudwatch_dashboard.platform.dashboard_name
}

output "unhealthy_target_alarm_name" {
  value = aws_cloudwatch_metric_alarm.unhealthy_targets.alarm_name
}

output "asg_capacity_alarm_name" {
  value = aws_cloudwatch_metric_alarm.asg_capacity.alarm_name
}