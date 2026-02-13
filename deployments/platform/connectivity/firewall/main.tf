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
  hub_rg              = data.terraform_remote_state.hub.outputs.resource_group_name
  hub_location        = var.location
  firewall_subnet_id  = data.terraform_remote_state.hub.outputs.subnet_ids["AzureFirewallSubnet"]
}

############################################
# Deploy Azure Firewall to Hub
############################################

module "hub_firewall" {
  source              = "../../../../modules/networking/firewall"
  enabled             = var.deploy_firewall
  name                = var.firewall_name
  firewall_policy_name = var.firewall_policy_name
  location            = local.hub_location
  resource_group_name = local.hub_rg
  subnet_id           = local.firewall_subnet_id
  sku_name            = "AZFW_Hub"
  sku_tier            = var.firewall_sku_tier
  tags                = var.tags
}
