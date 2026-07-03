data "azurerm_client_config" "current" {}

resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  vnet_name           = local.vnet_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "storage" {
  source              = "./modules/storage"
  name                = "st${var.project_name}${var.environment}${random_string.storage_suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = var.tags
}

module "app_configuration" {
  source              = "./modules/app_configuration"
  name                = local.app_config_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = var.app_config_sku
  tags                = var.tags
}

module "key_vault" {
  source              = "./modules/key_vault"
  name                = local.key_vault_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

module "acr" {
  source              = "./modules/acr"
  name                = local.acr_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = var.acr_sku
  tags                = var.tags
}

module "aks" {
  source              = "./modules/aks"
  name                = local.aks_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = "${var.project_name}-${var.environment}"
  subnet_id           = module.network.aks_subnet_id
  acr_id              = module.acr.id
  vm_size             = var.aks_vm_size
  min_count           = var.aks_min_count
  max_count           = var.aks_max_count
  tags                = var.tags
}

module "app_service" {
  source              = "./modules/app_service"
  plan_name           = local.app_plan_name
  web_app_name        = local.web_app_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.network.app_service_subnet_id
  sku_name            = var.app_service_sku
  key_vault_uri       = module.key_vault.vault_uri
  app_config_endpoint = module.app_configuration.endpoint
  tags                = var.tags
}

# Web App managed identity can read secrets from Key Vault
resource "azurerm_role_assignment" "webapp_kv_secrets" {
  scope                = module.key_vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.app_service.principal_id
}
