
variable "subscription_id" {
  type        = string
  description = "Prod landing zone subscription ID (injected later via pipeline)"
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


variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Enable BGP route propagation on the route table"
  default     = true
}


variable "hub_next_hop_ip" {
  type        = string
  description = "Private IP of hub firewall/NVA used for forced tunneling"
}

variable "tfstate_resource_group_name" {
  type        = string
  description = "Terraform state resource group"
  default     = "rg-robm-tf-state"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "Terraform state storage account"
  default     = "robmtfstate"
}

variable "tfstate_container_name" {
  type        = string
  description = "Terraform state container"
  default     = "tfstate"
}

variable "key_spoke_vnet" {
  type        = string
  description = "State key for prod VNet deployment"
  default     = "landingzones/lz-prod.tfstate"
}

variable "route_table_name" {
  type        = string
  description = "Route table name"
  default     = "rt-vnet-prd-spk-ne"
}

variable "spoke_subnet_name" {
  type        = string
  description = "Subnet name to associate the route table to"
  default     = "snet-prd-ne"
}
