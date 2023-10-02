variable "owner" {
  type = string
}

variable "repos" {
  type = list(object({
    name              = string
    plaintext_secrets = optional(map(string))
    encrypted_secrets = optional(map(string))
    variables         = optional(map(string))
  }))
  default = []
  # Example:
  # repos: [{
  #   name = "test"
  #   plaintext_secrets = {
  #     "MY_SECRET" = "42"
  #     "OWN_TOKEN" = "12345"
  #   }
  #   encrypted_secrets = {
  #     "MY_ENV_ENC_SECRET" = "MTIzNDU="
  #   }
  #   variables = {
  #     "Var0" = "val0"
  #   }
  # }]
}
