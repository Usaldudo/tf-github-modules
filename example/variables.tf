variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
variable "variables" {
  type = map(string)
}
variable "plaintext_secrets" {
  type = map(string)
}
variable "encrypted_secrets" {
  type = map(string)
}

variable "environments" {
  type    = any
  default = []
}
variable "repos" {
  type = list(object({
    name              = string
    plaintext_secrets = optional(map(string))
    encrypted_secrets = optional(map(string))
    variables         = optional(map(string))
  }))
}
