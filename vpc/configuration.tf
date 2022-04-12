terraform {
  required_version = "1.1.5"

  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "karin-terraform-state"
    key            = "vpc/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    encrypt        = true
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
