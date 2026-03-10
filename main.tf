provider "github" {
  token = var.GITHUB_TOKEN
  owner = "piyushnandu1996"
}

resource "random_string" "uniq_name" {
  length  = 5
  upper   = false
  special = false
}

resource "github_repository" "my_repo" {
  name        = "${var.repo_name}-${random_string.uniq_name.result}"
  description = "This repository is for devops engineer from SIGNAL TEAM"
  visibility  = "public"

  lifecycle {
    create_before_destroy = true
  }
}
