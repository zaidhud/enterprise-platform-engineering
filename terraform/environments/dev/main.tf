module "vpc" {
  source = "../../modules/vpc"

  project_name = "enterprise-platform-engineering"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "eu-west-2a",
    "eu-west-2b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_app_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  private_db_subnet_cidrs = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

module "compute" {
  source = "../../modules/compute"

  project_name      = "enterprise-platform-engineering"
  environment       = "dev"
  instance_type     = "t3.micro"
  security_group_id = module.vpc.app_security_group_id
}

module "load_balancer" {
  source = "../../modules/load-balancer"

  project_name          = "enterprise-platform-engineering"
  environment           = "dev"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.vpc.alb_security_group_id
  application_port      = 8080
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name       = "enterprise-platform-engineering"
  environment        = "dev"
  launch_template_id = module.compute.launch_template_id
  subnet_ids         = module.vpc.private_app_subnet_ids
  target_group_arns  = [module.load_balancer.target_group_arn]

  minimum_capacity = 2
  desired_capacity = 2
  maximum_capacity = 4
}