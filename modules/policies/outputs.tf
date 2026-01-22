
output "assignment_ids" {
  description = "Policy assignment IDs"
  value       = { for k, v in azurerm_policy_assignment.this : k => v.id }
}

