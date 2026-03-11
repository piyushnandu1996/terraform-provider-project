terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.35.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket-1996"
    dynamodb_table = "terraform-lock-table"
    key            = "ec2_rhel/terraform.tfstate"
    use_lockfile   = true
    region         = "ap-south-1"
    encrypt        = true


  }
}