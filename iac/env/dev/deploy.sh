
#! /bin/bash
set -e

# build image
docker-compose build

# push image to ECR repo
export AWS_PROFILE=wordpress-boilerplate
export AWS_DEFAULT_REGION=ap-southeast-2
login=$(aws ecr get-login --no-include-email) && eval "$login"
docker-compose push

# deploy image and env vars
fargate service deploy -f docker-compose.yml
