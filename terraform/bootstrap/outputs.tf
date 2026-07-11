output "terraform_state_bucket_name" {
  description = "S3 bucket used to store Terraform remote state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_lock_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "github_terraform_plan_role_arn" {
  description = "IAM role assumed by GitHub Actions through OIDC"
  value       = module.github_oidc.terraform_plan_role_arn
}