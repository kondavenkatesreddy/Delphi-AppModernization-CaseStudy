locals {
  resource_group_name = "rg-${var.resource_prefix}-001"
  vnet_name           = "vnet-${var.resource_prefix}-001"
  aks_name            = "aks-${var.resource_prefix}-001"
  acr_name            = replace("acr${var.project_name}${var.environment}uaen001", "-", "")
  key_vault_name      = "kv-${var.resource_prefix}-001"
  app_config_name     = "appcs-${var.resource_prefix}-001"
  app_plan_name       = "asp-${var.resource_prefix}-001"
  web_app_name        = "app-${var.resource_prefix}-001"
}
