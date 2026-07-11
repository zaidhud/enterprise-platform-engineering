variable "project_name" {
  description = "Name of the platform project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template used by the Auto Scaling Group"
  type        = string
}

variable "subnet_ids" {
  description = "Private application subnets used by the Auto Scaling Group"
  type        = list(string)
}

variable "minimum_capacity" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 0
}

variable "maximum_capacity" {
  description = "Maximum number of instances"
  type        = number
  default     = 4
}

variable "target_group_arns" {
  description = "ALB target groups used by the Auto Scaling Group"
  type        = list(string)
}