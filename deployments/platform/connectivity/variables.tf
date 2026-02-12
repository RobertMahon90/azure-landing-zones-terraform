variable "subscription_id" {
  type        = string
  description = "Connectivity subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the hub VNet"
  default     = "rg-vnet-hub-ne"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-hub-connectivity-ne"
}

variable "deploy_bastion" {
  type        = bool
  description = "Deploy Azure Bastion host to the hub VNet"
  default     = false
}

variable "bastion_name" {
  type        = string
  description = "Name of the Bastion host"
  default     = "bastion-hub-ne"
}

variable "bastion_sku" {
  type        = string
  description = "SKU for the Bastion host (Basic or Standard)"
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.bastion_sku)
    error_message = "Bastion SKU must be either 'Basic' or 'Standard'."
  }
}
