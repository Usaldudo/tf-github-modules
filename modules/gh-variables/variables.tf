variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
variable "variables" {
  description = "(Optional) Configuring actions variables. For details please check: https://www.terraform.io/docs/providers/github/r/actions_variable"
  type        = map(string)
  # Example:
  # variables = {
  #     "MY_VAR" = "42"
  # }

  default = {}
}
