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
# ExpressRoute Gateway configuration
############################################

variable "exr_gateway_name" {
  type        = string
  description = "ExpressRoute Gateway name"
  default     = "exrgw-hub-ne"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name for ExpressRoute Gateway"
  default     = "exrgw-hub-ne-pip"
}

variable "exr_sku" {
  type        = string
  description = "ExpressRoute Gateway SKU (ERGw1Az, ERGw2Az, ERGw3Az)"
  default     = "ERGw1Az"
  validation {
    condition     = contains(["ERGw1Az", "ERGw2Az", "ERGw3Az"], var.exr_sku)
    error_message = "ExpressRoute SKU must be either 'ERGw1Az', 'ERGw2Az', or 'ERGw3Az'."
  }
}
