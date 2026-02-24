
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

############################################
# Compliance Standards (Policy Sets)
############################################

variable "deploy_cis_benchmark" {
  type        = bool
  description = "Deploy CIS Microsoft Azure Foundations Benchmark v2.0.0"
  default     = true
}

variable "cis_benchmark_policy_set_id" {
  type        = string
  description = "Policy Set Definition ID for CIS Microsoft Azure Foundations Benchmark v2.0.0"
  default     = "/providers/Microsoft.Authorization/policySetDefinitions/06f19060-9e68-4070-92ca-f15cc126059e"
}

variable "deploy_mcsb_benchmark" {
  type        = bool
  description = "Deploy Microsoft Cloud Security Benchmark v1"
  default     = true
}

variable "mcsb_benchmark_policy_set_id" {
  type        = string
  description = "Policy Set Definition ID for Microsoft Cloud Security Benchmark v1"
  default     = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
}

variable "compliance_enforcement_mode" {
  type        = string
  description = "Enforcement mode for compliance policies: 'Default' (enforce) or 'DoNotEnforce' (audit-only)"
  default     = "Default"
  
  validation {
    condition     = contains(["Default", "DoNotEnforce"], var.compliance_enforcement_mode)
    error_message = "Enforcement mode must be 'Default' or 'DoNotEnforce'."
  }
}
