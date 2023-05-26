data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}

locals {
  repository_environment_map = { for id, e in var.environments : try(e._key, e.name) => id }
}

resource "github_repository_environment" "repository_environment" {
  for_each = local.repository_environment_map

  environment = var.environments[each.value].name
  repository  = var.repository
  wait_timer  = try(var.environments[each.value].wait_timer, 0)
  reviewers {
    users = try(var.environments[each.value].reviewers.users, [])
    teams = try(var.environments[each.value].reviewers.teams, [])
  }
  deployment_branch_policy {
    protected_branches     = try(var.environments[each.value].deployment_branch_policy.protected_branches, false)
    custom_branch_policies = try(var.environments[each.value].deployment_branch_policy.custom_branch_policies, true)
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Environment variable
# ---------------------------------------------------------------------------------------------------------------------

locals {
  environment_variables_map = merge([
    for env in var.environments :
    env.variables == null ? {} : {
      for name, value in env.variables :
      "${env.name}.${name}" => {
        variable    = value,
        name        = name,
        environment = env.name
      }
    }
  ]...)
}

resource "github_actions_environment_variable" "environment_variable" {
  for_each = local.environment_variables_map
  depends_on = [
    github_repository_environment.repository_environment
  ]
  repository    = var.repository
  environment   = each.value.environment
  variable_name = each.value.name
  value         = each.value.variable
}

# ---------------------------------------------------------------------------------------------------------------------
# Environment secrets
# ---------------------------------------------------------------------------------------------------------------------

locals {
  environment_plaintext_secrets = merge([
    for env in var.environments :
    env.plaintext_secrets == null ? {} : {
      for name, value in env.plaintext_secrets :
      "${env.name}.${name}" => {
        plaintext   = value,
        name        = name,
        environment = env.name
      }
    }
  ]...)
  environment_encrypted_secrets = merge([
    for env in var.environments :
    env.encrypted_secrets == null ? {} : {
      for name, value in env.encrypted_secrets :
      "${env.name}.${name}" => {
        encrypted   = value,
        name        = name,
        environment = env.name
      }
    }
  ]...)

  environment_secrets = merge(local.environment_plaintext_secrets, local.environment_encrypted_secrets)
}
resource "github_actions_environment_secret" "environment_secret" {
  for_each = local.environment_secrets
  depends_on = [
    github_repository_environment.repository_environment
  ]
  repository      = var.repository
  environment     = each.value.environment
  secret_name     = each.value.name
  plaintext_value = try(each.value.plaintext, null)
  encrypted_value = try(each.value.encrypted, null)
}
