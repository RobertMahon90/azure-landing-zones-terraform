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


# Create the RG first
resource "azurerm_resource_group" "hub_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_watcher" "hub_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  tags                = var.tags
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

  tags = var.tags
}

module "hub_bastion" {
  source              = "../../../modules/networking/bastion"
  enabled             = var.deploy_bastion
  name                = var.bastion_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  subnet_id           = module.hub_vnet.subnet_ids["AzureBastionSubnet"]
  sku                 = var.bastion_sku
  tags                = var.tags
}
