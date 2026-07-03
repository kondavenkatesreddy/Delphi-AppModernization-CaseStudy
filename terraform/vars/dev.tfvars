location        = "uaenorth"
environment     = "dev"
project_name    = "delphi"
resource_prefix = "delphi-dev-uaen"

aks_vm_size   = "Standard_B2s"
aks_min_count = 1
aks_max_count = 3

acr_sku         = "Standard"
app_service_sku = "B1"

tags = {
  Project     = "Delphi App Modernization"
  Environment = "Dev"
  Owner       = "Konda Venkateswar Reddy"
  ManagedBy   = "Terraform"
}
