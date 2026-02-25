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
  rg_service       = "Azure Monitoring"
  resource_service = "Log Analytics"
  built_date       = var.built_date
  created_by       = var.created_by
}

resource "azurerm_resource_group" "security_mon_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = module.alz_tags.rg_tags
}

resource "azurerm_log_analytics_workspace" "law_sec" {
  name                = var.law_name
  location            = var.location
  resource_group_name = azurerm_resource_group.security_mon_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_days

  tags = module.alz_tags.resource_tags
}

