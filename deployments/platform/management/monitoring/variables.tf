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
  description = "Resource group for management monitoring resources"
  default     = "rg-mon-mgmt-ne"
}

variable "law_name" {
  type        = string
  description = "Log Analytics workspace name"
  default     = "law-mgmt-ne"
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

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}
