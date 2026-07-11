variable "project_name" {
  description = "Name of the platform project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the load balancer and targets"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets used by the load balancer"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group attached to the load balancer"
  type        = string
}


variable "application_port" {
  description = "Port used by the application"
  type        = number
  default     = 8080
}
