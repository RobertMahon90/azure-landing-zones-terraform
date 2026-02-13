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

variable "deploy_bastion" {
  type        = bool
  description = "Deploy Azure Bastion host to the hub VNet"
  default     = true
}

variable "bastion_name" {
  type        = string
  description = "Name of the Bastion host"
  default     = "bastion-hub-ne"
}

variable "bastion_sku" {
  type        = string
  description = "SKU for the Bastion host (Basic or Standard)"
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.bastion_sku)
    error_message = "Bastion SKU must be either 'Basic' or 'Standard'."
  }
}

# Remote state configuration
variable "tfstate_resource_group_name" {
  type        = string
  description = "Resource group name for Terraform state storage"
  default     = "rg-alzdemo-tf-ne"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "Storage account name for Terraform state"
  default     = "alzdemotfstorne"
}

variable "tfstate_container_name" {
  type        = string
  description = "Container name for Terraform state"
  default     = "alzdemotfcont"
}

variable "key_hub" {
  type        = string
  description = "Terraform state key for hub connectivity"
  default     = "platform/connectivity.tfstate"
}
