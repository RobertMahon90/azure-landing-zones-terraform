# Monitoring Deployments

## Overview

The monitoring deployments provide observability infrastructure for each layer of the Azure Landing Zones architecture:

- **Log Analytics Workspace** (Management & Security only) - Centralized log aggregation and analysis
- **Service Health Alerts** (Tenant deployment) - Proactive cross-subscription notifications for Azure service incidents

## Service Health Alerting

Service health alerts are now centrally managed in the tenant deployment, providing a unified way to configure and deploy alerts across all 6 subscriptions (Management, Security, Connectivity, Identity, Prod LZ, Non-Prod LZ).

### Alert Configuration

All service health alerts are configured with the following scope:

| Parameter | Value |
|-----------|-------|
| **Services** | All (Global scope) |
| **Regions** | Global |
| **Event Types** | All (Incident, Maintenance, Informational, ActionRequired) |

This configuration monitors all Azure services across all regions.

### Notification Setup

Service health alerts trigger email notifications to configured recipients through Azure Monitor Action Groups. The alert configuration includes:

- **Action Group**: Named `ag-mon-{tier}` per deployment layer
- **Email Recipient**: Configured via `alert_email` variable in tenant deployment
- **Notification Method**: Direct email delivery

### Alert Architecture

| Subscription | Resource Group | Action Group | Alert Rule |
|-------|---|---|---|
| Management | rg-mon-mgmt-ne | ag-mon-mgmt | Service Health - Management |
| Security | rg-mon-sec-ne | ag-mon-sec | Service Health - Security |
| Connectivity | rg-mon-conn-ne | ag-mon-conn | Service Health - Connectivity |
| Identity | rg-mon-id-ne | ag-mon-id | Service Health - Identity |
| Prod LZ | rg-mon-prod-ne | ag-mon-prod | Service Health - Prod |
| Non-Prod LZ | rg-mon-nonprod-ne | ag-mon-nonprod | Service Health - Non-Prod |

All alerts are deployed from: `deployments/tenant/main.tf`

## Monitoring Deployments (Management & Security Only)

### Log Analytics Workspaces

Only Management and Security subscriptions maintain Log Analytics workspace deployments:

```
deployments/platform/management/monitoring/
├── main.tf           # Log Analytics workspace
├── variables.tf      # Input variables
├── outputs.tf        # LAW outputs
└── backend.tf        # Remote state

deployments/platform/security/monitoring/
├── main.tf           # Log Analytics workspace
├── variables.tf      # Input variables
├── outputs.tf        # LAW outputs
└── backend.tf        # Remote state
```

### Deployment Commands

Deploy Log Analytics workspace for a specific security tier:

```bash
# Management LAW
cd deployments/platform/management/monitoring
terraform init -backend-config=../../backend-config/management.hcl
terraform plan
terraform apply

# Security LAW
cd deployments/platform/security/monitoring
terraform init -backend-config=../../backend-config/security.hcl
terraform plan
terraform apply
```

## Service Health Alerts Deployment (Tenant)

Deploy all service health alerts centrally through the tenant deployment:

```bash
cd deployments/tenant
terraform init -backend-config=../backend-config/tenant.hcl
terraform plan
terraform apply
```

### Required Variables

The tenant deployment requires subscription IDs and alert email:

```hcl
# In terraform.tfvars or via command line:
alert_email                = "robert.mahon@eirbusiness.ie"
subscription_id_management = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
subscription_id_security   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
subscription_id_connectivity = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
subscription_id_identity   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
subscription_id_lz_prod    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
subscription_id_lz_nonprod = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

## Log Analytics Outputs

MgmtManagement and security monitoring deployments export:

- `law_id` - Resource ID of the Log Analytics workspace
- `law_name` - Name of the Log Analytics workspace
- `law_workspace_id` - Workspace ID for agent configuration
- `law_primary_shared_key` - Primary shared key (sensitive) for workspace access
- `resource_group_name` - Name of the monitoring resource group
- `resource_group_id` - Resource ID of the monitoring resource group

## Placeholder Deployments

Connectivity, Identity, Prod LZ, and Non-Prod LZ monitoring deployments are currently placeholders for future expansion. They maintain the same directory structure for consistency but do not deploy resources.

## Tagging

All monitoring resources follow the Azure Landing Zones tagging strategy:

```hcl
tags = {
  Tier       = "{deployment tier}"
  Service    = "Monitoring"
  Built      = "{creation date}"
  CreatedBy  = "{creator identifier}"
}
```

## Module Reference

### Service Health Alerts Module

Location: `modules/monitoring/service-health-alerts/`

Uses an **ARM template deployment** approach because service health alerts aren't directly supported as native Terraform resources. The module encapsulates:

- **Azure Monitor Action Group** (native Terraform resource) - Email receivers
- **Service Health Alert Rule** (via ARM template) - Alert configuration for all services, regions, and event types

This hybrid approach combines Terraform's native support for action groups with ARM template deployment for service health alerts, resulting in a streamlined and maintainable solution.

#### Module Inputs

| Parameter | Description | Type | Required |
|-----------|---|---|---|
| subscription_id | Azure subscription ID | string | Yes |
| resource_group_name | Name of resource group for alerts | string | Yes |
| action_group_name | Name of action group | string | Yes |
| alert_tier | Tier name for email display | string | Yes |
| alert_rule_name | Name of service health alert rule | string | Yes |
| email_address | Email for notifications | string | Yes |
| tags | Resource tags | map(string) | Yes |

#### Module Outputs

| Output | Description |
|--------|---|
| action_group_id | Service health action group resource ID |
| action_group_name | Service health action group name |
| alert_deployment_id | Service health alert ARM template deployment ID |
| alert_rule_name | Service health alert rule name |

## Best Practices

1. **Email Configuration**: Ensure the `alert_email` variable points to a monitored mailbox or distribution list for timely response to alerts.

2. **Multiple Recipients**: For broader notification, modify the azurerm_monitor_action_group resource in the module to include additional email receivers.

3. **Alert Response**: Establish runbooks and escalation procedures for different alert types (Incident, Maintenance, etc.).

4. **Log Retention**: Configure Log Analytics workspace retention policies in management/security monitoring deployments based on your compliance needs.

5. **Dashboard Creation**: Consider creating Azure Monitor dashboards that centralize service health status with other layer-specific metrics.

## Troubleshooting

### Alert Rule Not Creating

Ensure all subscription IDs are provided in tenant/terraform.tfvars and that provider authentication works for each subscription.

### Missing Email Notifications

Verify the alert rule is active and check the Action Group email receiver configuration. Emails may be filtered to spam folders.

### Provider Errors

Confirm service principal or managed identity has permissions to create resources in all 6 subscriptions.

## Related Documentation

- [Azure Monitor Service Health](https://docs.microsoft.com/en-us/azure/service-health/service-health-overview)
- [Azure Monitor Action Groups](https://docs.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
- [Logging and Monitoring in ALZ](../../../README.md#logging-and-monitoring)
