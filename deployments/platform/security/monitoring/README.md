# Security Monitoring Deployment

Modular deployment for security subscription monitoring resources including Log Analytics workspace and future service health alerts/action groups.

## Overview

This deployment is **independent** from the security networking layer, allowing monitoring resources to be managed, scaled, and updated separately. This structure enables:

- Independent alerting configuration per subscription
- Service health alert management
- Log retention policy updates without affecting networking
- Future action groups and alert rule deployments
- Separation of concerns between networking and observability

## Prerequisites

- Terraform >= 1.6
- Azure CLI authenticated to security subscription
- `security-monitoring.tfstate` backend configured
- Security subscription ID available

## Usage

### Plan

```bash
cd deployments/platform/security/monitoring
terraform init -backend-config=../../backend-config/security-monitoring.hcl
terraform plan
```

### Apply

```bash
terraform apply
```

Configure instance details with `-var-file` or environment variables:
```bash
terraform apply -var="law_name=law-sec-ne" -var="law_retention_days=90"
```

## Configuration

### Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `subscription_id` | Required | Security subscription ID |
| `location` | `northeurope` | Azure region for resources |
| `resource_group_name` | `rg-mon-sec-ne` | Resource group for monitoring resources |
| `law_name` | `law-sec-ne` | Log Analytics workspace name |
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

This deployment reads security subscription credentials from workflow environment variables. Updates to security networking (separate deployment) do not impact monitoring state.

## Next Steps

After initial LAW deployment:

1. **Configure diagnostic settings** - Route platform services logs to LAW
2. **Add service health alerts** - Create action groups and alert rules for Azure Service Health
3. **Set up threat detection** - Configure Microsoft Defender for Cloud integration
4. **Deploy monitoring agents** - Configure Log Analytics agents on VMs via separate IaC layer

## Related Deployments

- [Security VNet](../main.tf) - Core networking infrastructure
- [Security Routes](../routes/) - Routing configuration for security spoke
- [Management Monitoring](../../management/monitoring/) - Management subscription monitoring
