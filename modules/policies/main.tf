
locals {
  # Generate safe assignment names
  assignment_names = {
    for k, v in var.policy_assignments :
    k => substr(replace(lower(k), "_", "-"), 0, 64)
  }

  # Convert enforcement_mode -> enforce boolean
  enforce_map = {
    for k, v in var.policy_assignments :
    k => (try(v.enforcement_mode, "Default") != "DoNotEnforce")
  }
}

resource "azurerm_management_group_policy_assignment" "this" {
  for_each = var.policy_assignments

  name                 = local.assignment_names[each.key]
  management_group_id  = var.scope_id
  policy_definition_id = each.value.policy_definition_id

  display_name = try(each.value.display_name, null)
  parameters   = try(each.value.parameters, null)

  enforce = local.enforce_map[each.key]
}
