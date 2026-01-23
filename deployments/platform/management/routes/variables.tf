
variable "subscription_id" {
  type        = string
  description = "Management subscription ID (injected later via pipeline)"
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
  description = "TF state RG"
  default     = "rg-robm-tf-state"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "TF state storage account"
  default     = "robmtfstate"
}

variable "tfstate_container_name" {
  type        = string
  description = "TF state container"
  default     = "tfstate"
}

variable "key_spoke_vnet" {
  type        = string
  description = "State key for the spoke VNet deployment"
  default     = "platform/management.tfstate"
}

variable "route_table_name" {
  type        = string
  description = "Route table name"
  default     = "rt-vnet-mgmt-spk-ne"
}

variable "spoke_subnet_name" {
  type        = string
  description = "Subnet name to associate the route table to"
  default     = "snet-mgmt-ne"
}
