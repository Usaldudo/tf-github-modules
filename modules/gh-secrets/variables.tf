variable "repository" {
  type = string
}
variable "owner" {
  type = string
}
variable "secrets" {
  type = list(object({
    secret_name     = string
    encrypted_value = string
  }))
  default = [{
    secret_name     = "name1"
    encrypted_value = "FVutzYe1jzqHU8ZMSEyMndF24oVdFumRumYam7X8h27AwpAc1vkRQjKOh4e3XOw7akuCRjJDzv27Ph3FY8e7eQ=="
  }]
}
