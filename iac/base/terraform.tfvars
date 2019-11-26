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
