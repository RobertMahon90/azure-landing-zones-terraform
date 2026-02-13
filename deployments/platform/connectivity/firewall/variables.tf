variable "subscription_id" {
  type        = string
  description = "Connectivity subscription ID"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "deploy_firewall" {
  type        = bool
  description = "Deploy Azure Firewall to the hub VNet"
  default     = true
}

variable "firewall_name" {
  type        = string
  description = "Name of the Azure Firewall"
  default     = "azfw-hub-ne"
}

variable "firewall_sku_tier" {
  type        = string
  description = "SKU tier for the Firewall (Standard, Premium)"
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.firewall_sku_tier)
    error_message = "Firewall SKU tier must be either 'Standard' or 'Premium'."
  }
}

# Remote state configuration
variable "tfstate_resource_group_name" {
  type        = string
  description = "Resource group name for Terraform state storage"
  default     = "rg-alzdemo-tf-ne"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "Storage account name for Terraform state"
  default     = "alzdemotfstorne"
}

variable "tfstate_container_name" {
  type        = string
  description = "Container name for Terraform state"
  default     = "alzdemotfcont"
}

variable "key_hub" {
  type        = string
  description = "Terraform state key for hub connectivity"
  default     = "platform/connectivity.tfstate"
}
