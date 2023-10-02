locals {
  repo_map = { for id, r in var.repos : try(r._key, r.name) => id }
}
data "github_actions_public_key" "repo_public_key" {
  for_each   = local.repo_map
  repository = var.repos[each.value].name
}
locals {
  repository_plaintext_secrets = merge([
    for r in var.repos :
    r.plaintext_secrets == null ? {} : {
      for name, value in r.plaintext_secrets :
      "${r.name}.${name}" => {
        plaintext  = value,
        name       = name,
        repository = r.name
      }
    }
  ]...)
  repository_encrypted_secrets = merge([
    for r in var.repos :
    r.encrypted_secrets == null ? {} : {
      for name, value in r.encrypted_secrets :
      "${r.name}.${name}" => {
        encrypted  = value,
        name       = name,
        repository = r.name
      }
    }
  ]...)
  repository_secrets = merge(local.repository_plaintext_secrets, local.repository_encrypted_secrets)
  repository_variables = merge([
    for r in var.repos :
    r.variables == null ? {} : {
      for name, value in r.variables :
      "${r.name}.${name}" => {
        variable   = value,
        name       = name,
        repository = r.name
      }
    }
  ]...)

}

resource "github_actions_secret" "secret" {
  for_each        = local.repository_secrets
  repository      = each.value.repository
  secret_name     = each.value.name
  plaintext_value = try(each.value.plaintext, null)
  encrypted_value = try(each.value.encrypted, null)
}

resource "github_actions_variable" "variable" {
  for_each      = local.repository_variables
  repository    = each.value.repository
  variable_name = each.value.name
  value         = each.value.variable

}
