output "launch_template_id" {
  description = "ID of the application launch template"
  value       = aws_launch_template.application.id
}

output "ssm_role_name" {
  description = "IAM role used by the application instance"
  value       = aws_iam_role.ec2_ssm.name
}