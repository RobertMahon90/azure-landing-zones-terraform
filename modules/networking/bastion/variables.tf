variable "enabled" {
  type        = bool
  description = "Enable Bastion host deployment"
  default     = false
}

variable "name" {
  type        = string
  description = "Name of the Bastion host"
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
  description = "ID of the AzureBastionSubnet"
}

variable "sku" {
  type        = string
  description = "SKU for Bastion (Basic or Standard)"
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "SKU must be either 'Basic' or 'Standard'."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
