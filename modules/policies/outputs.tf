
output "assignment_ids" {
  description = "Policy assignment IDs (keyed by assignment map key)"
  value = {
    for k, v in azurerm_management_group_policy_assignment.this :
    k => v.id
  }
}
