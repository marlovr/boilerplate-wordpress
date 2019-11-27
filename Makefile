APP_NAME="wordpress-boilerplate"

reset:
	@bumpversion patch --new-version=1.0.0 --allow-dirty

base:
	@cd iac/env/base && \
	terraform init && \
	terraform apply --auto-approve

service:
	@cd iac/fargate && \
	terraform init && \
	terraform apply --auto-approve

build:
	@aws ecr get-login --no-include-email --region ap-southeast-2 | bash && \
	docker build -t $(APP_NAME) . && \
	docker tag $(APP_NAME):latest 776691755094.dkr.ecr.ap-southeast-2.amazonaws.com/$(APP_NAME):0.0.1 && \
	docker push 776691755094.dkr.ecr.ap-southeast-2.amazonaws.com/$(APP_NAME):0.0.1

deploy:
	@fargate service deploy -f docker-compose.yml --region ap-southeast-2 && \
	bumpversion patch --allow-dirty

destroy:
	@cd iac/fargate && \
	terraform destroy && \
	cd ../base && \
	terraform destroy