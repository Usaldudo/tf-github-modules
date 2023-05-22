variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
variable "variables" {
  type = list(object({
    variable_name = string
    value         = string
  }))
}
variable "secrets" {
  type = list(object({
    secret_name     = string
    encrypted_value = string
  }))
}
