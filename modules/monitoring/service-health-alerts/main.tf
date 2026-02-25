terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

# Create action group for service health alerts
resource "azurerm_monitor_action_group" "service_health" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = substr(var.action_group_name, 0, 12)

  email_receiver {
    name                    = "Email-${var.alert_tier}"
    email_address           = var.email_address
    use_common_alert_schema = true
  }

  tags = var.tags
}

# Create service health alert rule
resource "azurerm_monitor_service_health_alert_rule" "this" {
  name                = var.alert_rule_name
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Service Health alerts for ${var.alert_tier} - All services, regions (North Europe, West Europe, Global), and event types"
  enabled             = true

  action {
    action_group_id = azurerm_monitor_action_group.service_health.id
  }

  # All services
  services = ["Global"]

  # All regions: North Europe, West Europe, Global
  locations = ["Global", "North Europe", "West Europe"]

  # All event types
  events = ["Incident", "Maintenance", "Informational", "ActionRequired"]

  tags = var.tags
}
