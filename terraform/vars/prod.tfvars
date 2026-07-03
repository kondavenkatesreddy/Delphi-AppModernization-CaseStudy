# Production sizing. Larger nodes and App Service SKU for HA headroom.
location        = "uaenorth"
environment     = "prod"
project_name    = "delphi"
resource_prefix = "delphi-prod-uaen"

aks_vm_size   = "Standard_D2s_v5"
aks_min_count = 2
aks_max_count = 5

acr_sku         = "Premium"
app_service_sku = "P1v3"

tags = {
  Project     = "Delphi App Modernization"
  Environment = "Prod"
  ManagedBy   = "Terraform"
}
