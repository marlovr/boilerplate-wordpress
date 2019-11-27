locals {
  # Your token to logz.io
  logz_token = ""
  
  # Database
  db_user = "marlo"
  db_pass = ""
  db_name = "wpdb"

  # app/env to scaffold
  app         = "wordpress-boilerplate"
  environment = "dev"

  internal       = "false"
  container_port = "80"
  replicas       = "1"
  health_check   = "/"
  region         = "ap-southeast-2"
  aws_profile    = "wordpress-boilerplate"
  vpc            = "vpc-c6d1ffa1"
  public_subnets = "subnet-f0ecfa97,subnet-6bd15133,subnet-313b3878"
  tags = {
    application = "wordpress-boilerplate"
    environment = "dev"
  }
}

module "dev_base" {
  source      = "../../iac/base"
  app         = local.app
  environment = local.environment

  internal       = local.internal
  container_port = local.container_port
  replicas       = local.replicas
  health_check   = local.health_check
  region         = local.region
  aws_profile    = local.aws_profile
  vpc            = local.vpc
  public_subnets = local.public_subnets
  tags           = local.tags
}

module "dev_fargate" {
  source      = "../../iac/"
  app         = local.app
  environment = local.environment

  internal       = local.internal
  container_port = local.container_port
  replicas       = local.replicas
  health_check   = local.health_check
  region         = local.region
  aws_profile    = local.aws_profile
  vpc            = local.vpc
  public_subnets = local.public_subnets
  tags           = local.tags
}
