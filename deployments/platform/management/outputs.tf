
output "resource_group_name" {
  description = "Resource group containing the management spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Management spoke VNet name"
  value       = module.management_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Management spoke VNet resource ID"
  value       = module.management_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Management spoke VNet address space"
  value       = ["10.102.0.0/24"]
}

output "subnet_ids" {
  description = "Map of management spoke subnet IDs keyed by subnet name"
  value       = module.management_spoke_vnet.subnet_ids
}

output "law_mgmt_id" {
  description = "Management Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law_mgmt.id
}

output "law_mgmt_name" {
  description = "Management Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law_mgmt.name
}

output "law_mgmt_workspace_id" {
  description = "Management Log Analytics workspace ID (for agent configuration)"
  value       = azurerm_log_analytics_workspace.law_mgmt.workspace_id
}
