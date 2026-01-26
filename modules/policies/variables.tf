
variable "scope_id" {
  type        = string
  description = "Management Group resource ID where the policy assignments will be created."
}

variable "policy_assignments" {
  description = "Map of policy assignments to create at the Management Group scope."
  type = map(object({
    display_name         = optional(string)
    policy_definition_id = string
    parameters           = optional(string)
    enforcement_mode     = optional(string) # Default / DoNotEnforce
  }))
}
