data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}
module "variables" {
  source     = "../modules/gh-variables"
  variables  = var.variables
  repository = var.repository
  owner      = var.owner
}
module "secrets" {
  source     = "../modules/gh-secrets"
  secrets    = var.secrets
  repository = var.repository
  owner      = var.owner
}
