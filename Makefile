# Makefile - Cung cấp các command shortcuts cho dự án IaC

.PHONY: help deploy-aws plan-aws validate-aws create-projects

help:
	@echo "Các lệnh có sẵn:"
	@echo "  validate-aws         - Chạy 'terraform validate' cho môi trường AWS."
	@echo "  plan-aws             - Chạy 'terraform plan' cho môi trường AWS."
	@echo "  deploy-aws           - Chạy 'terraform apply' cho môi trường AWS."
	@echo "  create-projects      - Chạy script để tự động tạo các project trên GitLab."
	@echo "  provision-grafana    - Chạy script để tự động cấu hình Grafana."

validate-aws:
	@echo "==> Validating Terraform code for AWS..."
	@cd terraform/environments/aws && terraform init -backend=false && terraform validate

plan-aws:
	@echo "==> Planning Terraform changes for AWS..."
	@cd terraform/environments/aws && terraform init && terraform plan

deploy-aws:
	@echo "==> Applying Terraform changes for AWS..."
	@cd terraform/environments/aws && terraform init && terraform apply -auto-approve

create-projects:
	@echo "==> Running project onboarding script..."
	@cd scripts && ./create-projects.sh