
variable "location" {
  description = "Default Azure region"
  type        = string
  default     = "northeurope"
}


############################################
# Policy baseline inputs (Root MG: AlzDemo)
############################################

variable "allowed_locations" {
  type        = list(string)
  description = "Azure regions allowed for resource creation"
  default     = ["westeurope", "northeurope"]
}

variable "allowed_vm_skus" {
  type        = list(string)
  description = "Allowed VM size SKUs"
  default = [
    "Standard_D2s_v5", "Standard_D4s_v5", "Standard_D8s_v5",
    "Standard_E2s_v5", "Standard_E4s_v5", "Standard_E8s_v5",
    "Standard_F2s_v2", "Standard_F4s_v2", "Standard_F8s_v2"
  ]
}

variable "not_allowed_resource_types" {
  type        = list(string)
  description = "Resource types to deny"
  default     = ["Microsoft.Network/ddosProtectionPlans"]
}

############################################
# Built-in policy definition IDs (set later)
############################################

variable "def_allowed_locations" {
  type        = string
  description = "Policy Definition ID for 'Allowed locations'"
}

variable "def_allowed_rg_locations" {
  type        = string
  description = "Policy Definition ID for 'Allowed locations for resource groups'"
}

variable "def_allowed_vm_skus" {
  type        = string
  description = "Policy Definition ID for 'Allowed virtual machine size SKUs'"
}

variable "def_not_allowed_resource_types" {
  type        = string
  description = "Policy Definition ID for 'Not allowed resource types'"
}

variable "def_nic_no_public_ip" {
  type        = string
  description = "Policy Definition ID for 'Network interfaces should not have public IPs'"
}
