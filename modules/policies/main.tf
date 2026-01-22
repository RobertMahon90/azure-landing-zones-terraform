
resource "azurerm_policy_assignment" "this" {
  for_each = var.policy_assignments
}

