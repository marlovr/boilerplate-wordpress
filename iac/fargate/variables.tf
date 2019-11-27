/*
 * variables.tf
 * Common variables to use in various Terraform files (*.tf)
 */

# The AWS region to use for the dev environment's infrastructure
variable "region" {
  default = "ap-southeast-2"
}

# Tags for the infrastructure
variable "tags" {
  type = map(string)
}

# The application's name
variable "app" {
}

# The environment that is being built
variable "environment" {
}

# The port the container will listen on, used for load balancer health check
# Best practice is that this value is higher than 1024 so the container processes
# isn't running at root.
variable "container_port" {
}

# The port the load balancer will listen on
variable "lb_port" {
  default = "80"
}

# The load balancer protocol
variable "lb_protocol" {
  default = "HTTP"
}

# Network configuration

# The VPC to use for the Fargate cluster
variable "vpc" {
}

# The public subnets, minimum of 2, that are a part of the VPC(s)
variable "public_subnets" {
}

variable "db_user" {
  default = "marlo"
}

variable "db_pass" {
}

variable "db_name" {
  default = "wpdb"
}

# If the average CPU utilization over a minute drops to this threshold,
# the number of containers will be reduced (but not below ecs_autoscale_min_instances).
variable "ecs_as_cpu_low_threshold_per" {
  default = "20"
}

# If the average CPU utilization over a minute rises to this threshold,
# the number of containers will be increased (but not above ecs_autoscale_max_instances).
variable "ecs_as_cpu_high_threshold_per" {
  default = "80"
}

# Default scale up at 7 am weekdays, this is UTC so it doesn't adjust to daylight savings
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
variable "scale_up_cron" {
  default = "cron(0 11 ? * MON-FRI *)"
}

# Default scale down at 7 pm every day
variable "scale_down_cron" {
  default = "cron(0 23 * * ? *)"
}

# The mimimum number of containers to scale down to.
# Set this and `scale_down_max_capacity` to 0 to turn off service on the `scale_down_cron` schedule.
variable "scale_down_min_capacity" {
  default = 0
}

# The maximum number of containers to scale down to.
variable "scale_down_max_capacity" {
  default = 0
}

# How many containers to run
variable "replicas" {
  default = "1"
}

# The name of the container to run
variable "container_name" {
  default = "app"
}

# The minimum number of containers that should be running.
# Must be at least 1.
# used by both autoscale-perf.tf and autoscale.time.tf
# For production, consider using at least "2".
variable "ecs_autoscale_min_instances" {
  default = "1"
}

# The maximum number of containers that should be running.
# used by both autoscale-perf.tf and autoscale.time.tf
variable "ecs_autoscale_max_instances" {
  default = "8"
}

resource "aws_ecs_cluster" "app" {
  name = "${var.app}-${var.environment}"
  tags = var.tags
}

# Whether the application is available on the public internet,
# also will determine which subnets will be used (public or private)
variable "internal" {
  default = false
}

# The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused
variable "deregistration_delay" {
  default = "30"
}

# The path to the health check for the load balancer to know if the container(s) are ready
variable "health_check" {
}

# How often to check the liveliness of the container
variable "health_check_interval" {
  default = "30"
}

# How long to wait for the response on the health check path
variable "health_check_timeout" {
  default = "10"
}

# What HTTP response code to listen for
variable "health_check_matcher" {
  default = "200,302"
}

variable "lb_access_logs_expiration_days" {
  default = "3"
}

# The auth token to use for sending logs to Logz.io
variable "logz_token" {
  default = ""
}

# The endpoint to use for sending logs to Logz.io
variable "logz_url" {
  default = "https://listener.logz.io:8071"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the number of days you want to retain log events"
}

# The default docker image to deploy with the infrastructure.
variable "default_backend_image" {
  default = "776691755094.dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-boilerplate:0.0.4"
}
