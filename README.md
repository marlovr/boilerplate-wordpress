## New Project

- Clone repository as template
- Reset your template
  - `cd path/to/template`
  - `make reset`

## Configuration

### Terraform

- Edit your environment in `/deploy/dev/main.tf -> locals {}`

| Variable         | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `logz_token`     | Your token for logz.io                                                       |
| `app`            | Name of your application                                                     |
| `env`            | Environment of your application                                              |
| `aws_profile`    | AWS CLI profile (`aws configure --profile profile-name`)                     |
| `vpc`            | VPC ID (`aws console -> VPC` - Ususally default VPC)                         |
| `public_subnets` | Subnet IDs (`aws console -> VPC -> Subnets` - Usually 3 defaults, use these) |
| `region`         | AWS Region                                                                   |
| `tags`           | Tags for AWS resources created                                               |
| `container_port` | Port that your docker container uses for it's app                            |
| `replicas`       | Number of containers to run                                                  |
| `health_check`   | HTTP path to health check, usually `/`                                       |

### Build Config

- Edit `Makefile -> APP_NAME` to be the same as `app (terraform)`
- Edit `docker-compose.yml -> image`, change the name to your `app (terraform)`
  - e.g `/wordpress-boilerplate:0.0.4 -> /bland-monster:0.0.1`

## Initialize

From the base directory `./`

`make base`
`make service`

## Build Container

From the base directory `./`

`make build`

## Deploy Container

From the base directory `./`

`make deploy`

## Destroy Everything

From the base directory `./`

`make destroy`
