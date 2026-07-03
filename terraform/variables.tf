variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "aks_vm_size" {
  type = string
}

variable "aks_min_count" {
  type = number
}

variable "aks_max_count" {
  type = number
}

variable "acr_sku" {
  type = string
}

variable "app_service_sku" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_config_sku" {
  type    = string
  default = "free"
}