data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}

locals {
  plaintext_secrets = { for name, value in var.plaintext_secrets : name => { plaintext = value } }
  encrypted_secrets = { for name, value in var.encrypted_secrets : name => { encrypted = value } }

  secrets = merge(local.plaintext_secrets, local.encrypted_secrets)
}

resource "github_actions_secret" "gh_secrets" {
  for_each = local.secrets

  repository      = var.repository
  secret_name     = each.key
  plaintext_value = try(each.value.plaintext, null)
  encrypted_value = try(each.value.encrypted, null)
}
