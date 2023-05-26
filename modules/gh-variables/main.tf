data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}


locals {
  variables = { for name, value in var.variables : name => { variable = value } }
}

resource "github_actions_variable" "gh_variables" {
  for_each = local.variables

  repository    = var.repository
  variable_name = each.key
  value         = try(each.value.variable, null)
}
