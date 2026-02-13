# Virtual Network Module

Deploys an Azure Virtual Network with configurable subnets.

## Overview

Core module for creating VNets with dynamic subnet configuration. Used by all platform and spoke deployments.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | - | VNet resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `address_space` | list(string) | - | VNet address space (CIDR) |
| `subnets` | map(object) | `{}` | Subnets to create |
| `tags` | map(string) | `{}` | Resource tags |

## Subnet Configuration

Subnets are defined as a map of objects:

```hcl
subnets = {
  "SubnetName" = {
    address_prefixes = ["10.100.0.0/26"]
  }
  "AnotherSubnet" = {
    address_prefixes = ["10.100.1.0/27"]
  }
}
```

## Example Usage

```hcl
module "hub_vnet" {
  source = "../../modules/networking/vnet"
  
  name                = "vnet-hub-ne"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.100.0.0/22"]
  
  subnets = {
    AzureFirewallSubnet = { address_prefixes = ["10.100.0.0/26"] }
    GatewaySubnet       = { address_prefixes = ["10.100.1.0/27"] }
    AzureBastionSubnet  = { address_prefixes = ["10.100.2.0/26"] }
  }
  
  tags = var.tags
}
```

## Outputs

- `vnet_id`: VNet resource ID
- `vnet_name`: VNet resource name
- `subnet_ids`: Map of subnet names to subnet IDs

## Notes

- Subnet names like `GatewaySubnet` and `AzureBastionSubnet` are required by Azure services
- Always plan subnet sizes with future growth in mind
- Use /26 for firewall and bastion, /27+ for gateway
