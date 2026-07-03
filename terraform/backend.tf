# Remote state backend. Configure the storage account first, then run:
#   terraform init -backend-config=vars/dev.backend.hcl
# For a quick local run, leave this commented and use local state.

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-delphi-tfstate"
#     storage_account_name = "stdelphitfstate001"
#     container_name       = "tfstate"
#     key                  = "dev.terraform.tfstate"
#   }
# }
