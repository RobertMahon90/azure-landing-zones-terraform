variable "tier" {
  type        = string
  description = "Deployment tier (Prod, Non-Prod, Dev)"
  
  validation {
    condition     = contains(["Prod", "Non-Prod", "Dev"], var.tier)
    error_message = "Tier must be 'Prod', 'Non-Prod', or 'Dev'."
  }
}

variable "rg_service" {
  type        = string
  description = "Service name for resource group (e.g., 'Azure Networking', 'Azure Monitoring')"
}

variable "resource_service" {
  type        = string
  description = "Service/resource type for individual resources (e.g., 'Virtual Network', 'Log Analytics', 'Bastion', 'Firewall')"
}

variable "built_date" {
  type        = string
  description = "Date resources were built (ISO 8601 format: YYYY-MM-DD)"
  default     = ""
  
  validation {
    condition     = var.built_date == "" || can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.built_date))
    error_message = "Built date must be in ISO 8601 format (YYYY-MM-DD) or empty."
  }
}

variable "created_by" {
  type        = string
  description = "Organization/team that created the resources"
  default     = "eir business"
}
