
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
}

# Get current tenant context
data "azurerm_client_config" "current" {}

# Read the Tenant Root Management Group
data "azurerm_management_group" "tenant_root" {
  name = data.azurerm_client_config.current.tenant_id
}

# Top-level group under Tenant Root
module "alz_root" {
  source       = "../../modules/management-groups"
  name         = "AlzDemo" # MG ID (immutable)
  display_name = "AlzDemo"
  parent_id    = data.azurerm_management_group.tenant_root.id
}

# Children under AlzDemo
module "platform" {
  source       = "../../modules/management-groups"
  name         = "platform"
  display_name = "Platform"
  parent_id    = module.alz_root.id
}

module "landingzones" {
  source       = "../../modules/management-groups"
  name         = "landingzones"
  display_name = "Landing Zones"
  parent_id    = module.alz_root.id
}


# --- Platform children ---

module "identity" {
  source       = "../../modules/management-groups"
  name         = "identity"
  display_name = "Identity"
  parent_id    = module.platform.id
}

module "connectivity" {
  source       = "../../modules/management-groups"
  name         = "connectivity"
  display_name = "Connectivity"
  parent_id    = module.platform.id
}

module "management" {
  source       = "../../modules/management-groups"
  name         = "management"
  display_name = "Management"
  parent_id    = module.platform.id
}

module "security" {
  source       = "../../modules/management-groups"
  name         = "security"
  display_name = "Security"
  parent_id    = module.platform.id
}


# --- Landing Zones children ---

module "lz_prod" {
  source       = "../../modules/management-groups"
  name         = "lz-prod" # MG ID (immutable); keep IDs lowercase/hyphenated
  display_name = "Prod"
  parent_id    = module.landingzones.id
}

module "lz_nonprod" {
  source       = "../../modules/management-groups"
  name         = "lz-nonprod"
  display_name = "Non-Prod"
  parent_id    = module.landingzones.id
}


