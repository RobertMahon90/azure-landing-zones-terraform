output "resource_group_name" {
  description = "Resource group containing management monitoring resources"
  value       = azurerm_resource_group.management_mon_rg.name
}

output "resource_group_id" {
  description = "Resource group ID for management monitoring resources"
  value       = azurerm_resource_group.management_mon_rg.id
}

output "law_id" {
  description = "Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law_mgmt.id
}

output "law_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law_mgmt.name
}

output "law_workspace_id" {
  description = "Log Analytics workspace ID (for agent configuration)"
  value       = azurerm_log_analytics_workspace.law_mgmt.workspace_id
}

output "law_primary_shared_key" {
  description = "Log Analytics workspace primary shared key"
  value       = azurerm_log_analytics_workspace.law_mgmt.primary_shared_key
  sensitive   = true
}

