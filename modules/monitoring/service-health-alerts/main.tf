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

# Deploy service health alert rule via ARM template
resource "azurerm_resource_group_template_deployment" "service_health_alert" {
  name                = "${var.alert_rule_name}-deployment"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = jsonencode({
    schema          = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
    contentVersion  = "1.0.0.0"
    parameters      = {}
    variables       = {}
    resources = [
      {
        type       = "Microsoft.ServiceHealth/alerts"
        apiVersion = "2023-06-01-preview"
        name       = var.alert_rule_name
        location   = "global"
        properties = {
          description = "Service Health alerts for ${var.alert_tier}"
          actions = {
            actionGroups = [
              {
                actionGroupId = azurerm_monitor_action_group.service_health.id
              }
            ]
          }
          scopes = ["/subscriptions/${var.subscription_id}"]
          criteria = {
            alertScope   = "All"
            alertType    = "All"
            occurrenceType = "All"
          }
        }
        tags = var.tags
      }
    ]
  })

  depends_on = [azurerm_monitor_action_group.service_health]
}

