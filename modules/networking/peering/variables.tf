
variable "hub_peering_name" {
  type        = string
  description = "Name of the hub-to-spoke peering"
}

variable "spoke_peering_name" {
  type        = string
  description = "Name of the spoke-to-hub peering"
}

# Hub local VNet identifiers
variable "hub_resource_group_name" {
  type        = string
  description = "Resource group name for the hub VNet"
}

variable "hub_virtual_network_name" {
  type        = string
  description = "Hub VNet name"
}

# Spoke local VNet identifiers
variable "spoke_resource_group_name" {
  type        = string
  description = "Resource group name for the spoke VNet"
}

variable "spoke_virtual_network_name" {
  type        = string
  description = "Spoke VNet name"
}

# Remote VNet IDs (used by remote_virtual_network_id)
variable "hub_vnet_id" {
  type        = string
  description = "Hub VNet resource ID"
}

variable "spoke_vnet_id" {
  type        = string
  description = "Spoke VNet resource ID"
}

variable "allow_forwarded_traffic" {
  type        = bool
  description = "Allow forwarded traffic across peering"
  default     = true
}

variable "allow_virtual_network_access" {
  type        = bool
  description = "Allow virtual network access across peering"
  default     = true
}

variable "allow_gateway_transit" {
  type        = bool
  description = "Enable gateway transit on the hub peering"
  default     = true
}

variable "use_remote_gateways" {
  type        = bool
  description = "Enable remote gateway usage on the spoke peering"
  default     = false
}
