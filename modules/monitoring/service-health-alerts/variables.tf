variable "subscription_id" {
  type        = string
  description = "Azure subscription ID for service health alerts"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for monitoring resources"
}

variable "action_group_name" {
  type        = string
  description = "Name of the action group (e.g., ag-mon-mgmt)"
}

variable "alert_tier" {
  type        = string
  description = "Tier/Layer name for alert naming (e.g., Management, Security, Connectivity)"
}

variable "alert_rule_name" {
  type        = string
  description = "Display name of the service health alert rule"
}

variable "email_address" {
  type        = string
  description = "Email address for action group notifications"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
