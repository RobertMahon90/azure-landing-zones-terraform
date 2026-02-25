
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

provider "azurerm" {
  alias           = "management"
  features {}
  subscription_id = var.subscription_id_management
}

provider "azurerm" {
  alias           = "security"
  features {}
  subscription_id = var.subscription_id_security
}

provider "azurerm" {
  alias           = "connectivity"
  features {}
  subscription_id = var.subscription_id_connectivity
}

provider "azurerm" {
  alias           = "identity"
  features {}
  subscription_id = var.subscription_id_identity
}

provider "azurerm" {
  alias           = "lz_prod"
  features {}
  subscription_id = var.subscription_id_lz_prod
}

provider "azurerm" {
  alias           = "lz_nonprod"
  features {}
  subscription_id = var.subscription_id_lz_nonprod
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


################################################################################
# Service Health Alerts across all subscriptions
################################################################################

# Management subscription alerts
resource "azurerm_resource_group" "mgmt_alerts_rg" {
  provider = azurerm.management

  name     = "rg-mon-mgmt-ne"
  location = var.location
  tags = {
    Tier       = "Management"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_management" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.management }

  subscription_id      = var.subscription_id_management
  resource_group_name  = azurerm_resource_group.mgmt_alerts_rg.name
  action_group_name    = "ag-mon-mgmt"
  alert_tier           = "Management"
  alert_rule_name      = "Service Health - Management"
  email_address        = var.alert_email

  tags = {
    Tier       = "Management"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.mgmt_alerts_rg]
}

# Security subscription alerts
resource "azurerm_resource_group" "sec_alerts_rg" {
  provider = azurerm.security

  name     = "rg-mon-sec-ne"
  location = var.location
  tags = {
    Tier       = "Security"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_security" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.security }

  subscription_id      = var.subscription_id_security
  resource_group_name  = azurerm_resource_group.sec_alerts_rg.name
  action_group_name    = "ag-mon-sec"
  alert_tier           = "Security"
  alert_rule_name      = "Service Health - Security"
  email_address        = var.alert_email

  tags = {
    Tier       = "Security"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.sec_alerts_rg]
}

# Connectivity subscription alerts
resource "azurerm_resource_group" "conn_alerts_rg" {
  provider = azurerm.connectivity

  name     = "rg-mon-conn-ne"
  location = var.location
  tags = {
    Tier       = "Connectivity"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_connectivity" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.connectivity }

  subscription_id      = var.subscription_id_connectivity
  resource_group_name  = azurerm_resource_group.conn_alerts_rg.name
  action_group_name    = "ag-mon-conn"
  alert_tier           = "Connectivity"
  alert_rule_name      = "Service Health - Connectivity"
  email_address        = var.alert_email

  tags = {
    Tier       = "Connectivity"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.conn_alerts_rg]
}

# Identity subscription alerts
resource "azurerm_resource_group" "id_alerts_rg" {
  provider = azurerm.identity

  name     = "rg-mon-id-ne"
  location = var.location
  tags = {
    Tier       = "Identity"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_identity" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.identity }

  subscription_id      = var.subscription_id_identity
  resource_group_name  = azurerm_resource_group.id_alerts_rg.name
  action_group_name    = "ag-mon-id"
  alert_tier           = "Identity"
  alert_rule_name      = "Service Health - Identity"
  email_address        = var.alert_email

  tags = {
    Tier       = "Identity"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.id_alerts_rg]
}

# Prod landing zone subscription alerts
resource "azurerm_resource_group" "lz_prod_alerts_rg" {
  provider = azurerm.lz_prod

  name     = "rg-mon-prod-ne"
  location = var.location
  tags = {
    Tier       = "Prod"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_lz_prod" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.lz_prod }

  subscription_id      = var.subscription_id_lz_prod
  resource_group_name  = azurerm_resource_group.lz_prod_alerts_rg.name
  action_group_name    = "ag-mon-prod"
  alert_tier           = "Prod"
  alert_rule_name      = "Service Health - Prod"
  email_address        = var.alert_email

  tags = {
    Tier       = "Prod"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.lz_prod_alerts_rg]
}

# Non-Prod landing zone subscription alerts
resource "azurerm_resource_group" "lz_nonprod_alerts_rg" {
  provider = azurerm.lz_nonprod

  name     = "rg-mon-nonprod-ne"
  location = var.location
  tags = {
    Tier       = "Non-Prod"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }
}

module "service_health_alerts_lz_nonprod" {
  source = "../../modules/monitoring/service-health-alerts"

  providers = { azurerm = azurerm.lz_nonprod }

  subscription_id      = var.subscription_id_lz_nonprod
  resource_group_name  = azurerm_resource_group.lz_nonprod_alerts_rg.name
  action_group_name    = "ag-mon-nonprod"
  alert_tier           = "Non-Prod"
  alert_rule_name      = "Service Health - Non-Prod"
  email_address        = var.alert_email

  tags = {
    Tier       = "Non-Prod"
    Service    = "Monitoring"
    Built      = var.alert_built_date
    CreatedBy  = var.alert_created_by
  }

  depends_on = [azurerm_resource_group.lz_nonprod_alerts_rg]
}