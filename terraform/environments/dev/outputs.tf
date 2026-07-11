output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "alb_security_group_id" {
  value = module.vpc.alb_security_group_id
}

output "app_security_group_id" {
  value = module.vpc.app_security_group_id
}

output "db_security_group_id" {
  value = module.vpc.db_security_group_id
}

output "application_launch_template_id" {
  value = module.compute.launch_template_id
}

output "application_ssm_role_name" {
  value = module.compute.ssm_role_name
}

output "application_url" {
  description = "Public URL of the Document Service"
  value       = "http://${module.load_balancer.alb_dns_name}"
}

output "application_autoscaling_group_name" {
  value = module.autoscaling.autoscaling_group_name
}