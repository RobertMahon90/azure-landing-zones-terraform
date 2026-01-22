
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

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}
