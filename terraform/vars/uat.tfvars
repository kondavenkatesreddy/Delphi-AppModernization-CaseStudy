# UAT overrides. Same modules as dev with UAT sizing.
location        = "uaenorth"
environment     = "uat"
project_name    = "delphi"
resource_prefix = "delphi-uat-uaen"

aks_vm_size   = "Standard_B2s"
aks_min_count = 2
aks_max_count = 3

acr_sku         = "Standard"
app_service_sku = "B1"

tags = {
  Project     = "Delphi App Modernization"
  Environment = "UAT"
  ManagedBy   = "Terraform"
}
