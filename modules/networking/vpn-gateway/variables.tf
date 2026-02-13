variable "name" {
  type        = string
  description = "Name of the VPN Gateway"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "ID of the GatewaySubnet"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP for VPN Gateway"
}

variable "sku" {
  type        = string
  description = "VPN Gateway SKU (e.g., VpnGw1, VpnGw2, VpnGw1AZ, VpnGw2AZ)"
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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
