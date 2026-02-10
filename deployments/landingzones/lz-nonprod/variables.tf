variable "subscription_id" {
  type        = string
  description = "Non-prod landing zone subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the non-prod spoke VNet"
  default     = "rg-vnet-nprd-ne"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-nprd-lz-ne"
}
