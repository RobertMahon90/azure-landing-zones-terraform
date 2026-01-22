
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

module "prod_spoke_vnet" {
  source              = "../../../modules/networking/vnet"
  name                = "vnet-prd-spk-ne"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.104.0.0/24"]

  subnets = {
    snet-prd-ne = { address_prefixes = ["10.104.0.0/26"] }
  }

  tags = var.tags
}
