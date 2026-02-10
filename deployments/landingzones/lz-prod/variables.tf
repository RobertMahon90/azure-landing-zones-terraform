variable "subscription_id" {
  type        = string
  description = "Prod landing zone subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  default     = "northeurope"
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-vnet-prd-ne"
  description = "Resource group for the prod spoke VNet"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags"
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-prd-lz-ne"
}
