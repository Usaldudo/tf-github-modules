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
