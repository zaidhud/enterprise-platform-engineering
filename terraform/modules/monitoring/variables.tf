variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "load_balancer_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}

variable "autoscaling_group_name" {
  type = string
}