terraform {
  backend "azurerm" {
    resource_group_name  = "rg-robm-tf-state"
    storage_account_name = "robmtfstate"
    container_name       = "tfstate"
    key                  = "platform/connectivity-peerings.tfstate"
  }
}