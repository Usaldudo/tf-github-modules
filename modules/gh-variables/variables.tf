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
  default = [{
    variable_name = "name1"
    value         = "val2"
  }]
}
