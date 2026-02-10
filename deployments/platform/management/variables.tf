variable "subscription_id" {
  type        = string
  description = "Management subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the management spoke VNet"
  default     = "rg-vnet-mgmt-ne"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-mgmt-ne"
}
