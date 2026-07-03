variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku" {
  default = "standard"
}
variable "tags" {
  type    = map(string)
  default = {}
}
