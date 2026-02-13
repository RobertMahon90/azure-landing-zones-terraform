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
# Deploy VPN Gateway to Hub
############################################

module "hub_vpn_gateway" {
  source           = "../../../../modules/networking/vpn-gateway"
  name             = var.vpn_gateway_name
  location         = local.hub_location
  resource_group_name = local.hub_rg
  subnet_id        = local.gateway_subnet_id
  public_ip_name   = var.public_ip_name
  sku              = var.vpn_sku
  enable_active_active = var.enable_active_active
  enable_bgp       = var.enable_bgp
  bgp_asn          = var.bgp_asn
  bgp_peering_address = var.bgp_peering_address
  tags             = var.tags
}
