variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
variable "plaintext_secrets" {
  description = "(Optional) Configuring actions secrets. For details please check: https://www.terraform.io/docs/providers/github/r/actions_secret"
  type        = map(string)

  # Example:
  # plaintext_secrets = {
  #     "MY_SECRET" = "42"
  #     "OWN_TOKEN" = "12345"
  # }

  default = {}
}
variable "encrypted_secrets" {
  description = "(Optional) Configuring encrypted actions secrets. For details please check: https://www.terraform.io/docs/providers/github/r/actions_secret"
  type        = map(string)

  # Example:
  # encrypted_secrets = {
  #     "MY_ENCRYPTED_SECRET" = "MTIzNDU="
  # }

  default = {}
}
