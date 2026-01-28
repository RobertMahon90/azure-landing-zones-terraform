
############################################
# Subscription IDs (injected later via Azure DevOps)
############################################

variable "sub_connectivity" {
  type        = string
  description = "Connectivity (hub) subscription ID"
}

variable "sub_identity" {
  type        = string
  description = "Identity spoke subscription ID"
}

variable "sub_management" {
  type        = string
  description = "Management spoke subscription ID"
}

variable "sub_security" {
  type        = string
  description = "Security spoke subscription ID"
}

variable "sub_lz_prod" {
  type        = string
  description = "Prod landing zone subscription ID"
}

variable "sub_lz_nonprod" {
  type        = string
  description = "Non-prod landing zone subscription ID"
}


############################################
# Remote state backend location (override in pipelines if needed)
############################################

variable "tfstate_resource_group_name" {
  type        = string
  description = "Resource group containing the Terraform state storage account"
  default     = "rg-alzdemo-tf-ne"
}

variable "tfstate_storage_account_name" {
  type        = string
  description = "Terraform state storage account name"
  default     = "alzdemotfstorne"
}

variable "tfstate_container_name" {
  type        = string
  description = "Terraform state container name"
  default     = "alzdemotfcont"
}


############################################
# State keys (must match backend.tf keys in each layer)
############################################

variable "key_hub" {
  type        = string
  description = "State key for hub connectivity deployment"
  default     = "platform/connectivity.tfstate"
}

variable "key_identity" {
  type        = string
  description = "State key for identity deployment"
  default     = "platform/identity.tfstate"
}

variable "key_management" {
  type        = string
  description = "State key for management deployment"
  default     = "platform/management.tfstate"
}

variable "key_security" {
  type        = string
  description = "State key for security deployment"
  default     = "platform/security.tfstate"
}

variable "key_lz_prod" {
  type        = string
  description = "State key for prod landing zone deployment"
  default     = "landingzones/lz-prod.tfstate"
}

variable "key_lz_nonprod" {
  type        = string
  description = "State key for non-prod landing zone deployment"
  default     = "landingzones/lz-nonprod.tfstate"
}

############################################
# Peering behaviour
############################################

variable "allow_forwarded_traffic" {
  type        = bool
  description = "Allow forwarded traffic across peering"
  default     = true
}

variable "enable_gateway_transit" {
  type        = bool
  description = "If true, hub allows gateway transit and spokes use remote gateways"
  default     = true
}
