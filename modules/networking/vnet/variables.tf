
variable "name" {
  type        = string
  description = "VNet name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the VNet"
}

variable "location" {
  type        = string
  description = "Azure region (e.g., northeurope)"
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
  description = "Map of subnets to create"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
