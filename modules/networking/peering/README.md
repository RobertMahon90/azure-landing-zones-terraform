# VNet Peering Module

Establishes peering between hub and spoke virtual networks.

## Overview

Configures bidirectional VNet peering between hub and spoke networks, enabling traffic flow and optional gateway transit.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `hub_peering_name` | string | - | Hub-side peering name |
| `spoke_peering_name` | string | - | Spoke-side peering name |
| `hub_resource_group_name` | string | - | Hub RG |
| `spoke_resource_group_name` | string | - | Spoke RG |
| `hub_virtual_network_name` | string | - | Hub VNet name |
| `spoke_virtual_network_name` | string | - | Spoke VNet name |
| `hub_vnet_id` | string | - | Hub VNet ID |
| `spoke_vnet_id` | string | - | Spoke VNet ID |
| `allow_virtual_network_access` | bool | `true` | Allow traffic between VNets |
| `allow_forwarded_traffic` | bool | `true` | Allow forwarded traffic |
| `allow_gateway_transit` | bool | `true` | Hub allows transit through gateway |
| `use_remote_gateways` | bool | `false` | Spoke uses hub gateway |

## Usage Pattern

Requires provider aliases for cross-subscription peering:

```hcl
provider "azurerm" {
  alias           = "hub"
  subscription_id = var.hub_subscription_id
}

provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.spoke_subscription_id
}

module "peering" {
  source = "../../modules/networking/peering"
  
  providers = {
    azurerm.hub   = azurerm.hub
    azurerm.spoke = azurerm.spoke
  }
  
  hub_peering_name = "hub-to-spoke"
  # ... other parameters
}
```

## Outputs

- Hub peering resource reference
- Spoke peering resource reference
