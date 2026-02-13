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

resource "azurerm_resource_group" "security_rg" {
  name     = var.resource_group_name
  location = var.location              
  tags     = var.tags
}

resource "azurerm_resource_group" "security_mon_rg" {
  name     = var.mon_resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_watcher" "security_nw" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.security_rg.name
  tags                = var.tags
}

resource "azurerm_network_security_group" "security_nsg" {
  for_each = module.security_spoke_vnet.subnet_ids

  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = azurerm_resource_group.security_rg.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "security_nsg_assoc" {
  for_each = module.security_spoke_vnet.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.security_nsg[each.key].id
}

module "security_spoke_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-sec-spk-ne"
  resource_group_name = azurerm_resource_group.security_rg.name
  location            = var.location
  address_space       = ["10.103.0.0/24"]

  subnets = {
    snet-sec-ne = { address_prefixes = ["10.103.0.0/26"] }
  }

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "law_sec" {
  name                = var.law_sec_name
  location            = var.location
  resource_group_name = azurerm_resource_group.security_mon_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_days

  tags = var.tags
}
