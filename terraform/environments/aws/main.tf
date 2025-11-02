# Đây là file chính để định nghĩa hạ tầng cho môi trường AWS

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Cấu hình remote backend để lưu state file trên S3
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket-iac"
  #   key            = "aws/terraform.tfstate"
  #   region         = "ap-southeast-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region
}

# Ví dụ: Gọi module EKS để tạo một cụm Kubernetes
module "eks_cluster_dev" {
  source = "../../modules/eks" # Đường dẫn tới module EKS

  cluster_name = "my-eks-cluster-dev"
}