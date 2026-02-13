# ExpressRoute Gateway Module

Deploys an Azure ExpressRoute Gateway for private ExpressRoute connectivity.

## Overview

ExpressRoute Gateway enables private, dedicated connectivity to Microsoft cloud services. This module creates:

- Virtual Network Gateway (ExpressRoute type)
- Static public IP with availability zones
- BGP always enabled (required for ExpressRoute)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | - | Gateway resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `subnet_id` | string | - | GatewaySubnet ID |
| `public_ip_name` | string | - | Public IP name |
| `sku` | string | `ERGw1Az` | SKU (ERGw1Az, ERGw2Az, ERGw3Az) |
| `tags` | map(string) | `{}` | Resource tags |

## Subnet Requirement

ExpressRoute Gateway **must** be deployed in a subnet explicitly named `GatewaySubnet`.

## Important Notes

- **BGP is always enabled** - Required for ExpressRoute
- ASN and peering addresses are configured server-side
- Gateway deployment takes 20-30 minutes
- Requires ExpressRoute circuit in same Azure region

## SKU Selection

- **ERGw1Az**: Standard performance (default)
- **ERGw2Az**: Higher performance
- **ERGw3Az**: Ultra-high performance

All are availability-zone capable (`Az` suffix).

## Example Usage

```hcl
module "expressroute_gateway" {
  source = "../../modules/networking/expressroute-gateway"
  
  name             = "exrgw-hub-ne"
  location         = "northeurope"
  resource_group_name = azurerm_resource_group.hub.name
  subnet_id        = azurerm_subnet.gateway.id
  public_ip_name   = "pip-exrgw-hub-ne"
  sku              = "ERGw1Az"
  tags             = var.tags
}
```

## Outputs

- `gateway_id`: Resource ID
- `gateway_name`: Gateway name
- `public_ip_address`: Gateway public IP
- `bgp_settings`: BGP configuration details
