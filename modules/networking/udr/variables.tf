
variable "name" {
  type        = string
  description = "Route table name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the route table is created"
}

variable "location" {
  type        = string
  description = "Azure region"
}


variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Controls propagation of routes learned by BGP on the route table. Defaults to true."
  default     = true
}


variable "routes" {
  description = "Routes to create in the route table"
  type = map(object({
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {}
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs to associate route table to"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
