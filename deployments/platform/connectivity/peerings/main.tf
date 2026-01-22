
terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

#############################
# Providers (one per subscription)
#############################

provider "azurerm" {
  alias = "hub"
  features {}
  subscription_id = var.sub_connectivity
}

provider "azurerm" {
  alias = "identity"
  features {}
  subscription_id = var.sub_identity
}

provider "azurerm" {
  alias = "management"
  features {}
  subscription_id = var.sub_management
}

provider "azurerm" {
  alias = "security"
  features {}
  subscription_id = var.sub_security
}

provider "azurerm" {
  alias = "lz_prod"
  features {}
  subscription_id = var.sub_lz_prod
}

provider "azurerm" {
  alias = "lz_nonprod"
  features {}
  subscription_id = var.sub_lz_nonprod
}

#############################
# Read VNet IDs from each layer's state
#############################

data "terraform_remote_state" "hub" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_hub
  }
}

data "terraform_remote_state" "identity" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_identity
  }
}

data "terraform_remote_state" "management" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_management
  }
}

data "terraform_remote_state" "security" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_security
  }
}

data "terraform_remote_state" "lz_prod" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_lz_prod
  }
}

data "terraform_remote_state" "lz_nonprod" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    key                  = var.key_lz_nonprod
  }
}

#############################
# Local identifiers + VNet IDs
#############################

locals {
  # Hub identifiers
  hub_rg   = "rg-vnet-hub-ne"
  hub_vnet = "vnet-hub-ne"

  # Spoke identifiers
  id_rg   = "rg-vnet-id-ne"
  id_vnet = "vnet-id-spk-ne"

  mgmt_rg   = "rg-vnet-mgmt-ne"
  mgmt_vnet = "vnet-mgmt-spk-ne"

  sec_rg   = "rg-vnet-sec-ne"
  sec_vnet = "vnet-sec-spk-ne"

  prd_rg   = "rg-vnet-prd-ne"
  prd_vnet = "vnet-prd-spk-ne"

  nprd_rg   = "rg-vnet-nprd-ne"
  nprd_vnet = "vnet-nprod-spk-ne"

  # VNet IDs from remote state outputs (these exist because your VNet module outputs vnet_id)
  hub_vnet_id  = data.terraform_remote_state.hub.outputs.vnet_id
  id_vnet_id   = data.terraform_remote_state.identity.outputs.vnet_id
  mgmt_vnet_id = data.terraform_remote_state.management.outputs.vnet_id
  sec_vnet_id  = data.terraform_remote_state.security.outputs.vnet_id
  prd_vnet_id  = data.terraform_remote_state.lz_prod.outputs.vnet_id
  nprd_vnet_id = data.terraform_remote_state.lz_nonprod.outputs.vnet_id

  allow_gateway_transit = var.enable_gateway_transit
  use_remote_gateways   = var.enable_gateway_transit
}

#############################
# Peerings (Hub <-> Spokes) with gateway transit enabled
#############################

module "peer_identity" {
  source = "../../../../modules/networking/peering"

  hub_peering_name   = "peer-hub-to-id-ne"
  spoke_peering_name = "peer-id-to-hub-ne"

  hub_resource_group_name    = local.hub_rg
  hub_virtual_network_name   = local.hub_vnet
  spoke_resource_group_name  = local.id_rg
  spoke_virtual_network_name = local.id_vnet

  hub_vnet_id   = local.hub_vnet_id
  spoke_vnet_id = local.id_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = local.allow_gateway_transit
  use_remote_gateways     = local.use_remote_gateways

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.identity
  }
}

module "peer_management" {
  source = "../../../../modules/networking/peering"

  hub_peering_name   = "peer-hub-to-mgmt-ne"
  spoke_peering_name = "peer-mgmt-to-hub-ne"

  hub_resource_group_name    = local.hub_rg
  hub_virtual_network_name   = local.hub_vnet
  spoke_resource_group_name  = local.mgmt_rg
  spoke_virtual_network_name = local.mgmt_vnet

  hub_vnet_id   = local.hub_vnet_id
  spoke_vnet_id = local.mgmt_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = local.allow_gateway_transit
  use_remote_gateways     = local.use_remote_gateways

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.management
  }
}

module "peer_security" {
  source = "../../../../modules/networking/peering"

  hub_peering_name   = "peer-hub-to-sec-ne"
  spoke_peering_name = "peer-sec-to-hub-ne"

  hub_resource_group_name    = local.hub_rg
  hub_virtual_network_name   = local.hub_vnet
  spoke_resource_group_name  = local.sec_rg
  spoke_virtual_network_name = local.sec_vnet

  hub_vnet_id   = local.hub_vnet_id
  spoke_vnet_id = local.sec_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = local.allow_gateway_transit
  use_remote_gateways     = local.use_remote_gateways

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.security
  }
}

module "peer_prod" {
  source = "../../../../modules/networking/peering"

  hub_peering_name   = "peer-hub-to-prd-ne"
  spoke_peering_name = "peer-prd-to-hub-ne"

  hub_resource_group_name    = local.hub_rg
  hub_virtual_network_name   = local.hub_vnet
  spoke_resource_group_name  = local.prd_rg
  spoke_virtual_network_name = local.prd_vnet

  hub_vnet_id   = local.hub_vnet_id
  spoke_vnet_id = local.prd_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = local.allow_gateway_transit
  use_remote_gateways     = local.use_remote_gateways

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.lz_prod
  }
}

module "peer_nonprod" {
  source = "../../../../modules/networking/peering"

  hub_peering_name   = "peer-hub-to-nprd-ne"
  spoke_peering_name = "peer-nprd-to-hub-ne"

  hub_resource_group_name    = local.hub_rg
  hub_virtual_network_name   = local.hub_vnet
  spoke_resource_group_name  = local.nprd_rg
  spoke_virtual_network_name = local.nprd_vnet

  hub_vnet_id   = local.hub_vnet_id
  spoke_vnet_id = local.nprd_vnet_id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = local.allow_gateway_transit
  use_remote_gateways     = local.use_remote_gateways

  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.lz_nonprod
  }
}
