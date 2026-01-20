terraform {
  backend "azurerm" {
    resource_group_name  = "rg-robm-tf-state"
    storage_account_name = "robmtfstate" # change to yours
    container_name       = "tfstate"
    key                  = "tenant/management-groups.tfstate"
  }
}
