
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

############################################
# Read Hub outputs from connectivity layer state
############################################

data "terraform_remote_state" "hub" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_hub
  }
}

locals {
  hub_rg            = data.terraform_remote_state.hub.outputs.resource_group_name
  hub_location      = var.location
  gateway_subnet_id = data.terraform_remote_state.hub.outputs.subnet_ids["GatewaySubnet"]
}

############################################
# Public IP for VPN Gateway
############################################

resource "azurerm_public_ip" "vpngw" {
  name                = var.public_ip_name
  resource_group_name = local.hub_rg
  location            = local.hub_location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

############################################
# VPN Gateway
############################################

resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = var.vpn_gateway_name
  resource_group_name = local.hub_rg
  location            = local.hub_location

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = var.vpn_sku

  active_active = var.enable_active_active
  enable_bgp    = var.enable_bgp

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = local.gateway_subnet_id
  }

  dynamic "bgp_settings" {
    for_each = var.enable_bgp ? [1] : []
    content {
      asn = var.bgp_asn

      dynamic "peering_addresses" {
        for_each = var.bgp_peering_address == null ? [] : [1]
        content {
          ip_configuration_name = "vnetGatewayConfig"
          apipa_addresses       = [var.bgp_peering_address]
        }
      }
    }
  }

  tags = var.tags
}
