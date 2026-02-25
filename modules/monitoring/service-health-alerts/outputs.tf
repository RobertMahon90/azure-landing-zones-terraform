output "action_group_id" {
  value       = azurerm_monitor_action_group.service_health.id
  description = "ID of the service health action group"
}

output "action_group_name" {
  value       = azurerm_monitor_action_group.service_health.name
  description = "Name of the service health action group"
}

output "alert_rule_id" {
  value       = azurerm_monitor_service_health_alert_rule.this.id
  description = "ID of the service health alert rule"
}

output "alert_rule_name" {
  value       = azurerm_monitor_service_health_alert_rule.this.name
  description = "Name of the service health alert rule"
}
