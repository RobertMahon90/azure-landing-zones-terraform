output "resource_group_name" {
  description = "Resource group containing security monitoring resources"
  value       = azurerm_resource_group.security_mon_rg.name
}

output "resource_group_id" {
  description = "Resource group ID for security monitoring resources"
  value       = azurerm_resource_group.security_mon_rg.id
}

output "law_id" {
  description = "Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law_sec.id
}

output "law_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law_sec.name
}

output "law_workspace_id" {
  description = "Log Analytics workspace ID (for agent configuration)"
  value       = azurerm_log_analytics_workspace.law_sec.workspace_id
}

output "law_primary_shared_key" {
  description = "Log Analytics workspace primary shared key"
  value       = azurerm_log_analytics_workspace.law_sec.primary_shared_key
  sensitive   = true
}
