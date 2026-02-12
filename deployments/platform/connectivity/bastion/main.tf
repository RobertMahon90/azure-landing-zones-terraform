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
  bastion_subnet_id = data.terraform_remote_state.hub.outputs.subnet_ids["AzureBastionSubnet"]
}

############################################
# Deploy Bastion to Hub
############################################

module "hub_bastion" {
  source              = "../../../../modules/networking/bastion"
  enabled             = var.deploy_bastion
  name                = var.bastion_name
  location            = local.hub_location
  resource_group_name = local.hub_rg
  subnet_id           = local.bastion_subnet_id
  sku                 = var.bastion_sku
  tags                = var.tags
}
