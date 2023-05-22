data "github_actions_public_key" "repo_public_key" {
  repository = var.repository
}

resource "github_actions_variable" "gh_variables" {
  for_each = { for v in var.variables : v.variable_name => v }

  repository    = var.repository
  variable_name = each.value.variable_name
  value         = each.value.value
}
