terraform {
  required_version = "1.1.5"

  backend "s3" {
    region  = "ap-northeast-2"
    bucket  = "karin-terraform-state"
    key     = "alb/terraform.tfstate"
    encrypt = true

    # Terraform 동시 실행 방지를 위한 락 테이블
    dynamodb_table = "terraform-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region  = "ap-northeast-2"
    bucket  = "karin-terraform-state"
    key     = "vpc/terraform.tfstate"
    encrypt = true
  }
}
