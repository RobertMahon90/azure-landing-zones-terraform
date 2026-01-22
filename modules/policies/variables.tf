
variable "scope_id" {
  description = "The scope (management group or subscription ID) where policies are assigned"
  type        = string
}

variable "policy_assignments" {
  description = "Map of policy or initiative assignments"
  type = map(object({
    policy_definition_id = string
    display_name         = string
    parameters           = optional(string, null) # jsonencode(...) string
    enforcement_mode     = optional(string, "Default")
    description          = optional(string, null)
  }))
}
