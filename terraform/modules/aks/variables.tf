variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "subnet_id" {}
variable "acr_id" {}
variable "vm_size" {
  default = "Standard_B2s"
}
variable "min_count" {
  default = 1
}
variable "max_count" {
  default = 3
}
variable "tags" {
  type    = map(string)
  default = {}
}
