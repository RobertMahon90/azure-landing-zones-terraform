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
  rg_service       = "Azure Networking - Non-Production"
  resource_service = "Virtual Network"
  built_date       = var.built_date
  created_by       = var.created_by
}

locals {
  nsg_tags             = merge(module.alz_tags.resource_tags, { Service = "Network Security Group" })
  network_watcher_tags = merge(module.alz_tags.resource_tags, { Service = "Network Watcher" })
}

# Create the Resource Group first
  resource "azurerm_resource_group" "nonprod_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = module.alz_tags.rg_tags
}

resource "azurerm_network_watcher" "nonprod_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.nonprod_rg.name
  tags                = local.network_watcher_tags
}

resource "azurerm_network_security_group" "nonprod_nsg" {
  for_each = module.nonprod_spoke_vnet.subnet_ids

  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.nonprod_rg.name
  tags                = local.nsg_tags
}

resource "azurerm_subnet_network_security_group_association" "nonprod_nsg_assoc" {
  for_each = module.nonprod_spoke_vnet.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nonprod_nsg[each.key].id
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

  tags = module.alz_tags.resource_tags
}
