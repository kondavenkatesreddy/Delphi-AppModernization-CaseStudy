variable "plan_name" {}
variable "web_app_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "sku_name" {
  default = "B1"
}
variable "always_on" {
  default = false
}
variable "key_vault_uri" {
  default = ""
}
variable "app_config_endpoint" {
  default = ""
}
variable "tags" {
  type    = map(string)
  default = {}
}
