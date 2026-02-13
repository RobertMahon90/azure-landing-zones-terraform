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

resource "azurerm_resource_group" "management_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = var.tags
}

resource "azurerm_resource_group" "management_mon_rg" {
  name     = var.mon_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_watcher" "management_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.management_rg.name
  tags                = var.tags
}

resource "azurerm_network_security_group" "management_nsg" {
  for_each = module.management_spoke_vnet.subnet_ids

  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.management_rg.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "management_nsg_assoc" {
  for_each = module.management_spoke_vnet.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.management_nsg[each.key].id
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

resource "azurerm_log_analytics_workspace" "law_mgmt" {
  name                = var.law_mgmt_name
  location            = var.location
  resource_group_name = azurerm_resource_group.management_mon_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_days

  tags = var.tags
}
