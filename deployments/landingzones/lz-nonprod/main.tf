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
  resource "azurerm_resource_group" "nonprod_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = var.tags
}

resource "azurerm_network_watcher" "nonprod_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.nonprod_rg.name
  tags                = var.tags
}

module "nonprod_spoke_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-nprod-spk-ne"
  resource_group_name = azurerm_resource_group.nonprod_rg.name
  location            = var.location
  address_space       = ["10.105.0.0/24"]

  subnets = {
    snet-nprd-ne = { address_prefixes = ["10.105.0.0/26"] }
  }

  tags = var.tags
}
