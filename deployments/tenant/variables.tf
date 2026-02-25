
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

############################################
# Service Health Alerts inputs
############################################

variable "alert_email" {
  type        = string
  description = "Email address for service health alert notifications"
  sensitive   = true
}

variable "alert_built_date" {
  type        = string
  description = "Date service health alerts were deployed (ISO 8601 format: YYYY-MM-DD)"
  default     = "2026-02-25"
}

variable "alert_created_by" {
  type        = string
  description = "Team/organization that created service health alerts"
  default     = "eir business"
}

variable "subscription_id_management" {
  type        = string
  description = "Management subscription ID"
}

variable "subscription_id_security" {
  type        = string
  description = "Security subscription ID"
}

variable "subscription_id_connectivity" {
  type        = string
  description = "Connectivity subscription ID"
}

variable "subscription_id_identity" {
  type        = string
  description = "Identity subscription ID"
}

variable "subscription_id_lz_prod" {
  type        = string
  description = "Prod landing zone subscription ID"
}

variable "subscription_id_lz_nonprod" {
  type        = string
  description = "Non-Prod landing zone subscription ID"
}
