terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket-1996"
    dynamodb_table = "terraform-lock-table"
    key            = "piyush-ec2/terraform.tfstat"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true

  }
}

provider "aws" {
  region = "ap-south-1"
}