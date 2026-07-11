variable "project_name" {
  description = "Name of the platform project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}


variable "security_group_id" {
  description = "Application security group attached to the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}