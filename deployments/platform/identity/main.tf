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
resource "azurerm_resource_group" "identity_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = var.tags
}

resource "azurerm_network_watcher" "identity_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.identity_rg.name
  tags                = var.tags
}

resource "azurerm_network_security_group" "identity_nsg" {
  for_each = module.identity_spoke_vnet.subnet_ids

  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.identity_rg.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "identity_nsg_assoc" {
  for_each = module.identity_spoke_vnet.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.identity_nsg[each.key].id
}

module "identity_spoke_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-id-spk-ne"
  resource_group_name = azurerm_resource_group.identity_rg.name
  location            = var.location
  address_space       = ["10.101.0.0/24"]

  subnets = {
    snet-adds-ne = { address_prefixes = ["10.101.0.0/26"] }
  }

  tags = var.tags
}
