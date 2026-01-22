
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
