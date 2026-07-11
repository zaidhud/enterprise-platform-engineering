variable "github_owner" {
  type        = string
  description = "GitHub organisation or username"
}

variable "github_repository" {
  type        = string
  description = "GitHub repository name"
}

variable "terraform_state_bucket_arn" {
  type        = string
  description = "ARN of the Terraform state bucket"
}

variable "terraform_lock_table_arn" {
  type        = string
  description = "ARN of the Terraform lock table"
}