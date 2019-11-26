## New Project

- Clone repository as template
- Edit all `terraform.tfvar` files

```
- terraform.tfvars
- /iac/env/dev/terraform.tfvars
- /iac/base/terraform.tfvars
```

| Variable         | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
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

## Init

`make base`

## Build

`make build`

## Deploy

`make deploy`
