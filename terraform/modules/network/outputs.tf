output "vnet_id" {
  value = azurerm_virtual_network.this.id
}
output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}
output "app_service_subnet_id" {
  value = azurerm_subnet.app_service.id
}
output "aks_nsg_id" {
  value = azurerm_network_security_group.aks.id
}
output "app_service_nsg_id" {
  value = azurerm_network_security_group.app_service.id
}
