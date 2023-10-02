locals {
  repo_public_keys = data.github_actions_public_key.repo_public_key
}

output "repo_public_key" {
  value = {
    for repo_name, repo_data in local.repo_public_keys :
    repo_name => repo_data.key
  }
}
