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

module "alz_tags" {
  source           = "../../../modules/tags_alz"
  tier             = var.tier
  rg_service       = "Azure Networking - Hub"
  resource_service = "Virtual Network"
  built_date       = var.built_date
  created_by       = var.created_by
}


# Create the RG first
resource "azurerm_resource_group" "hub_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = module.alz_tags.rg_tags
}

resource "azurerm_network_watcher" "hub_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  tags                = module.alz_tags.resource_tags
}

module "hub_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-hub-ne"
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = var.location
  address_space       = ["10.100.0.0/22"]

  subnets = {
    AzureFirewallSubnet = { address_prefixes = ["10.100.0.0/26"] }
    GatewaySubnet       = { address_prefixes = ["10.100.1.0/27"] }
    AzureBastionSubnet  = { address_prefixes = ["10.100.2.0/26"] }
  }

  tags = module.alz_tags.resource_tags
}
