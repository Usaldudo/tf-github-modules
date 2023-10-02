terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.4.0, <=v1.5.7" # avoid BSL
}
provider "github" {
  owner = var.owner
}
