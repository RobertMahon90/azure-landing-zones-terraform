variable "subscription_id" {
  type        = string
  description = "Security subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the security spoke VNet"
  default     = "rg-vnet-sec-ne"
}

variable "mon_resource_group_name" {
  type        = string
  description = "Resource group for security monitoring resources"
  default     = "rg-mon-sec-ne"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-sec-ne"
}

variable "law_sec_name" {
  type        = string
  description = "Log Analytics workspace name for security"
  default     = "law-sec-ne"
}

variable "law_sku" {
  type        = string
  description = "Log Analytics workspace SKU"
  default     = "PerGB2018"
}

variable "law_retention_days" {
  type        = number
  description = "Log Analytics workspace retention in days"
  default     = 30
}
