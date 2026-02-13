
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
  source           = "../../../../modules/tags_alz"
  tier             = var.tier
  rg_service       = "Azure Routing - Production"
  resource_service = "Route Table"
  built_date       = var.built_date
  created_by       = var.created_by
}

data "terraform_remote_state" "spoke" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_spoke_vnet
  }
}

locals {
  rg_name   = data.terraform_remote_state.spoke.outputs.resource_group_name
  subnet_id = data.terraform_remote_state.spoke.outputs.subnet_ids[var.spoke_subnet_name]
}

module "udr" {
  source              = "../../../../modules/networking/udr"
  name                = var.route_table_name
  resource_group_name = local.rg_name
  location            = var.location
  tags                = module.alz_tags.resource_tags

  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled

  routes = {
    default_to_hub = {
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = var.hub_next_hop_ip
    }
  }

  subnet_ids = {
    (var.spoke_subnet_name) = local.subnet_id
  }
}
