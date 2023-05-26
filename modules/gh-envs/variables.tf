variable "environments" {
  description = "A list of environments to apply to the repository. Default is []."
  type = list(object({
    name       = string
    wait_timer = optional(number, 0)
    reviewers = optional(object({
      users = optional(list(number), [])
      teams = optional(list(number), [])
    }))
    deployment_branch_policy = object({
      protected_branches     = bool
      custom_branch_policies = bool
    })
    variables         = optional(map(string))
    plaintext_secrets = optional(map(string))
    encrypted_secrets = optional(map(string))
  }))
  default = []
  # # Example:
  # environments = [{
  #   name       = "test"
  #   wait_timer = 10
  #   reviewers = {
  #     users = [data.github_user.current.id]
  #     teams = []
  #   }
  #   deployment_branch_policy = {
  #     protected_branches     = true
  #     custom_branch_policies = false
  #   }
  #   variables = {
  #     MY_ENV_VAR  = "42"
  #     MY_ENV_VAR2 = "mysecondvar"
  #   }
  #   plaintext_secrets = {
  #     "MY_ENV_SECRET" = "secret"
  #   }
  #   encrypted_secrets = {
  #     "MY_ENV_ENC_SECRET" = "MTIzNDU="
  #   }
  # }]
}

variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
