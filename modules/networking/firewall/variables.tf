variable "enabled" {
  type        = bool
  description = "Enable Azure Firewall deployment"
  default     = false
}

variable "name" {
  type        = string
  description = "Name of the Azure Firewall"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "ID of the AzureFirewallSubnet"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the Firewall (AZFW_Hub or AZFW_VNet)"
  default     = "AZFW_Hub"
  validation {
    condition     = contains(["AZFW_Hub", "AZFW_VNet"], var.sku_name)
    error_message = "SKU name must be either 'AZFW_Hub' or 'AZFW_VNet'."
  }
}

variable "sku_tier" {
  type        = string
  description = "SKU tier for the Firewall (Standard, Premium)"
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.sku_tier)
    error_message = "SKU tier must be either 'Standard' or 'Premium'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
