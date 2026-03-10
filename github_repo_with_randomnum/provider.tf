terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.11.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket-1996"
    dynamodb_table = "terraform-lock-table"
    key            = "github_ran/terraform.tfstate"
    encrypt        = true
    use_lockfile   = true
    region         = "ap-south-1"
  }
}

