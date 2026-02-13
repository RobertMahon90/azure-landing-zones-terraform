variable "name" {
  type        = string
  description = "Name of the ExpressRoute Gateway"
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
  description = "Name of the public IP for ExpressRoute Gateway"
}

variable "sku" {
  type        = string
  description = "ExpressRoute Gateway SKU (ERGw1Az, ERGw2Az, ERGw3Az)"
  default     = "ERGw1Az"
  validation {
    condition     = contains(["ERGw1Az", "ERGw2Az", "ERGw3Az"], var.sku)
    error_message = "SKU must be either 'ERGw1Az', 'ERGw2Az', or 'ERGw3Az'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
