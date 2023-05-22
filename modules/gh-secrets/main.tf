data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}

resource "github_actions_secret" "gh_secrets" {
  for_each = { for s in var.secrets : s.secret_name => s }

  repository      = var.repository
  secret_name     = each.value.secret_name
  encrypted_value = each.value.encrypted_value
}
