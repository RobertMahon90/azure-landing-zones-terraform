# Management Monitoring Deployment

Modular deployment for management subscription monitoring resources including Log Analytics workspace and future service health alerts/action groups.

## Overview

This deployment is **independent** from the management networking layer, allowing monitoring resources to be managed, scaled, and updated separately. This structure enables:

- Independent alerting configuration per subscription
- Service health alert management
- Log retention policy updates without affecting networking
- Future action groups and alert rule deployments
- Separation of concerns between networking and observability

## Prerequisites

- Terraform >= 1.6
- Azure CLI authenticated to management subscription
- `management-monitoring.tfstate` backend configured
- Management subscription ID available

## Usage

### Plan

```bash
cd deployments/platform/management/monitoring
terraform init -backend-config=../../backend-config/management-monitoring.hcl
terraform plan
```

### Apply

```bash
terraform apply
```

Configure instance details with `-var-file` or environment variables:
```bash
terraform apply -var="law_name=law-mgmt-ne" -var="law_retention_days=90"
```

## Configuration

### Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `subscription_id` | Required | Management subscription ID |
| `location` | `northeurope` | Azure region for resources |
| `resource_group_name` | `rg-mon-mgmt-ne` | Resource group for monitoring resources |
| `law_name` | `law-mgmt-ne` | Log Analytics workspace name |
| `law_sku` | `PerGB2018` | LAW pricing tier |
| `law_retention_days` | `30` | Data retention in days |
| `tags` | `{}` | Common resource tags |

## Outputs

| Output | Description |
|--------|-------------|
| `resource_group_name` | Monitoring resource group name |
| `resource_group_id` | Monitoring resource group ID |
| `law_id` | Log Analytics workspace resource ID |
| `law_name` | Log Analytics workspace name |
| `law_workspace_id` | LAW workspace ID for agent configuration |
| `law_primary_shared_key` | LAW primary shared key (sensitive) |

## Remote State

This deployment reads management subscription credentials from workflow environment variables. Updates to management networking (separate deployment) do not impact monitoring state.

## Next Steps

After initial LAW deployment:

1. **Configure diagnostic settings** - Route platform services logs to LAW
2. **Add service health alerts** - Create action groups and alert rules for Azure Service Health
3. **Set up threat detection** - Configure Microsoft Defender for Cloud integration
4. **Deploy monitoring agents** - Configure Log Analytics agents on VMs via separate IaC layer

## Related Deployments

- [Management VNet](../main.tf) - Core networking infrastructure
- [Management Routes](../routes/) - Routing configuration for management spoke
- [Security Monitoring](../../security/monitoring/) - Security subscription monitoring
