# Azure Firewall Module

Deploys Azure Firewall with a firewall policy to the hub VNet.

## Overview

Azure Firewall provides centralized network protection and policy enforcement. This module creates:

- Azure Firewall resource (Standard or Premium tier)
- Firewall Policy
- Static public IP (Standard SKU)
- Conditional deployment support

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enabled` | bool | `false` | Deploy Firewall when `true` |
| `name` | string | - | Firewall resource name |
| `firewall_policy_name` | string | - | Policy resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `subnet_id` | string | - | AzureFirewallSubnet ID |
| `sku_name` | string | `AZFW_Hub` | SKU name (AZFW_Hub or AZFW_VNet) |
| `sku_tier` | string | `Standard` | Tier: Standard or Premium |
| `tags` | map(string) | `{}` | Resource tags |

## Subnet Requirement

Firewall **must** be deployed in a subnet explicitly named `AzureFirewallSubnet` with `/26` or larger prefix.

## SKU Notes

- **AZFW_Hub**: For hub deployments (recommended for ALZ)
- **AZFW_VNet**: For spoke deployments (not used in this ALZ)
- **Standard**: Basic DPI, less performance
- **Premium**: Advanced threat protection, higher throughput

## Example Usage

```hcl
module "firewall" {
  source = "../../modules/networking/firewall"
  
  enabled              = true
  name                 = "azfw-hub-ne"
  firewall_policy_name = "azfw-hub-policy-ne"
  location             = "northeurope"
  resource_group_name  = azurerm_resource_group.hub.name
  subnet_id            = azurerm_subnet.firewall.id
  sku_name             = "AZFW_Hub"
  sku_tier             = "Standard"
  tags                 = var.tags
}
```

## Outputs

- `firewall_id`: Resource ID
- `firewall_name`: Firewall name
- `firewall_private_ip`: Internal IP
- `public_ip_address`: Firewall public IP
- `firewall_policy_id`: Policy resource ID
- `firewall_policy_name`: Policy name
