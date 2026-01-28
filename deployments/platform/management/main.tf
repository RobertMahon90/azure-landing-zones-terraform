
terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Create the Resource Group first
  resource "azurerm_resource_group" "management_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = var.tags
}
module "management_spoke_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-mgmt-spk-ne"
  resource_group_name = azurerm_resource_group.management_rg.name
  location            = var.location
  address_space       = ["10.102.0.0/24"]

  subnets = {
    snet-mgmt-ne = { address_prefixes = ["10.102.0.0/26"] }
  }

  tags = var.tags
}
