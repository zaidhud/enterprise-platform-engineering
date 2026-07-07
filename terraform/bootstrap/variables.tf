variable "aws_region" {
  description = "AWS region used for the platform bootstrap resources"
  type        = string
}

variable "project_name" {
  description = "Name of the platform project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "owner" {
  description = "Unique owner identifier"
  type        = string
}