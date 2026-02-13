############################################
# Subscription and location
############################################

variable "subscription_id" {
  type        = string
  description = "Connectivity subscription ID"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "northeurope"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
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

############################################
# Remote state backend (hub connectivity layer)
############################################

variable "tfstate_resource_group_name" {
  type        = string
  description = "Resource group containing the Terraform state storage account"
  default     = "rg-alzdemo-tf-ne"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "Terraform state storage account name"
  default     = "alzdemotfstorne"
}

variable "tfstate_container_name" {
  type        = string
  description = "Terraform state container name"
  default     = "alzdemotfcont"
}

variable "key_hub" {
  type        = string
  description = "State key for hub connectivity deployment"
  default     = "platform/connectivity.tfstate"
}

############################################
# VPN Gateway configuration
############################################

variable "vpn_gateway_name" {
  type        = string
  description = "VPN Gateway name"
  default     = "vpngw-hub-ne"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name for VPN Gateway"
  default     = "vpngw-hub-ne-pip"
}

variable "vpn_sku" {
  type        = string
  description = "VPN Gateway SKU (e.g., VpnGw1AZ, VpnGw2AZ)"
  default     = "VpnGw1AZ"
}

variable "enable_active_active" {
  type        = bool
  description = "Enable Active-Active configuration"
  default     = false
}

variable "enable_bgp" {
  type        = bool
  description = "Enable BGP"
  default     = false
}

variable "bgp_asn" {
  type        = number
  description = "BGP ASN"
  default     = 65515
}

variable "bgp_peering_address" {
  type        = string
  description = "BGP peering address (optional)"
  default     = null
}
