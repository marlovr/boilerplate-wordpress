build:
	aws ecr get-login --no-include-email --region ap-southeast-2 | bash && \
	docker build -t wordpress-boilerplate . && \
	docker tag wordpress-boilerplate:latest 776691755094.dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-boilerplate:0.0.4 && \
	docker push 776691755094.dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-boilerplate:0.0.4

base:
	cd iac/env/base && \
	terraform init && \
	terraform apply --auto-approve

deploy:
	cd iac/env/dev && \
	terraform init && \
	terraform apply --auto-approve && \
	fargate service deploy -f docker-compose.yml --region ap-southeast-2 && \
	cd ../../ && \
	bumpversion patch --allow-dirty