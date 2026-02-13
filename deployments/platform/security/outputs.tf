
output "resource_group_name" {
  description = "Resource group containing the security spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Security spoke VNet name"
  value       = module.security_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Security spoke VNet resource ID"
  value       = module.security_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Security spoke VNet address space"
  value       = ["10.103.0.0/24"]
}

output "subnet_ids" {
  description = "Map of security spoke subnet IDs keyed by subnet name"
  value       = module.security_spoke_vnet.subnet_ids
}

output "law_sec_id" {
  description = "Security Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.law_sec.id
}

output "law_sec_name" {
  description = "Security Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.law_sec.name
}

output "law_sec_workspace_id" {
  description = "Security Log Analytics workspace ID (for agent configuration)"
  value       = azurerm_log_analytics_workspace.law_sec.workspace_id
}
