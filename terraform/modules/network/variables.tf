variable "vnet_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "address_space" {
  type    = list(string)
  default = ["10.10.0.0/16"]
}
variable "aks_subnet_prefix" {
  type    = list(string)
  default = ["10.10.1.0/24"]
}
variable "app_service_subnet_prefix" {
  type    = list(string)
  default = ["10.10.2.0/24"]
}
variable "tags" {
  type    = map(string)
  default = {}
}
