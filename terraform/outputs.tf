output "resource_group_name" {
  value = module.resource_group.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "aks_name" {
  value = module.aks.name
}

output "web_app_hostname" {
  value = module.app_service.default_hostname
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "storage_account_name" {
  value = module.storage.name
}

output "app_configuration_endpoint" {
  value = module.app_configuration.endpoint
}

output "log_analytics_workspace_id" {
  value = module.monitoring.log_analytics_workspace_id
}
output "application_insights_name" {
  value = module.monitoring.application_insights_name
}
output "application_insights_instrumentation_key" {
  value = module.monitoring.application_insights_instrumentation_key
}
