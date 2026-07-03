variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "replication_type" {
  default = "LRS"
}
variable "tags" {
  type    = map(string)
  default = {}
}
