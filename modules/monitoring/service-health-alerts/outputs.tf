output "action_group_id" {
  value       = azurerm_monitor_action_group.service_health.id
  description = "ID of the service health action group"
}

output "action_group_name" {
  value       = azurerm_monitor_action_group.service_health.name
  description = "Name of the service health action group"
}

output "alert_deployment_id" {
  value       = azurerm_resource_group_template_deployment.service_health_alert.id
  description = "ID of the service health alert rule ARM template deployment"
}

output "alert_rule_name" {
  value       = var.alert_rule_name
  description = "Name of the service health alert rule"
}
