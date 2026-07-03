variable "name" {}
variable "workspace_name" {}
variable "app_insights_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "aks_resource_id" {}
variable "app_service_resource_id" {}
variable "tags" {
  type    = map(string)
  default = {}
}
