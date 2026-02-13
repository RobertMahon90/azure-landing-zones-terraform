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
  description = "Additional custom tags (merged with ALZ tags)"
  default     = {}
}

variable "network_watcher_name" {
  description = "Name of the Network Watcher"
  type        = string
  default     = "nw-id-ne"
}

variable "tier" {
  type        = string
  description = "Deployment tier (Prod, Non-Prod, Dev)"
  default     = "Prod"

  validation {
    condition     = contains(["Prod", "Non-Prod", "Dev"], var.tier)
    error_message = "Tier must be 'Prod', 'Non-Prod', or 'Dev'."
  }
}

variable "built_date" {
  type        = string
  description = "Date resources were built (ISO 8601 format: YYYY-MM-DD)"
  default     = "2026-02-13"
}

variable "created_by" {
  type        = string
  description = "Organization/team that created the resources"
  default     = "eir business"
}
