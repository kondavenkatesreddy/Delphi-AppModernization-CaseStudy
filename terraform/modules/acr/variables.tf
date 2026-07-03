variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku" {
  default = "Standard"
}
variable "tags" {
  type    = map(string)
  default = {}
}
