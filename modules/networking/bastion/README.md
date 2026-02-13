# Azure Bastion Module

Deploys Azure Bastion host to a hub VNet for RDP/SSH access to VMs.

## Overview

Azure Bastion provides secure shell access to VMs without exposing public IPs or SSH/RDP ports. This module creates:

- Azure Bastion host resource
- Static public IP (Standard SKU)
- Conditional deployment support

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enabled` | bool | `false` | Deploy Bastion when `true` |
| `name` | string | - | Bastion resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `subnet_id` | string | - | AzureBastionSubnet ID |
| `sku` | string | `Basic` | SKU: Basic or Standard |
| `tags` | map(string) | `{}` | Resource tags |

## Subnet Requirement

Bastion **must** be deployed in a subnet explicitly named `AzureBastionSubnet` with `/26` or larger prefix.

## Example Usage

```hcl
module "bastion" {
  source = "../../modules/networking/bastion"
  
  enabled             = true
  name                = "bastion-hub-ne"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.hub.name
  subnet_id           = azurerm_subnet.bastion.id
  sku                 = "Basic"
  tags                = var.tags
}
```

## Outputs

- `bastion_id`: Resource ID of the Bastion host
- `bastion_name`: Bastion resource name
- `public_ip_id`: Public IP resource ID
- `public_ip_address`: Public IP address
