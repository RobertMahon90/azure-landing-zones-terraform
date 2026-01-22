
variable "subscription_id" {
  type        = string
  description = "Identity subscription ID (injected by pipeline later)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the identity spoke VNet"
  default     = "rg-vnet-id-ne"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}
