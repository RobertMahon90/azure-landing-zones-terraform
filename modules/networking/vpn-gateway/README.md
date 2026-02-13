# VPN Gateway Module

Deploys an Azure VPN Gateway for site-to-site and point-to-site connectivity.

## Overview

VPN Gateway enables hybrid connectivity from on-premises networks. This module creates:

- Virtual Network Gateway (Vpn type)
- Route-Based VPN
- Static public IP with availability zones
- Optional Active-Active configuration
- Optional BGP support

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | - | Gateway resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `subnet_id` | string | - | GatewaySubnet ID |
| `public_ip_name` | string | - | Public IP name |
| `sku` | string | `VpnGw1AZ` | SKU (VpnGw1AZ, VpnGw2AZ, VpnGw3AZ) |
| `enable_active_active` | bool | `false` | Active-Active setup |
| `enable_bgp` | bool | `false` | Enable BGP |
| `bgp_asn` | number | `65515` | BGP ASN |
| `bgp_peering_address` | string | `null` | BGP peering address |
| `tags` | map(string) | `{}` | Resource tags |

## Subnet Requirement

VPN Gateway **must** be deployed in a subnet explicitly named `GatewaySubnet`.

## SKU Selection

- **VpnGw1AZ**: Single instance with availability zones (default)
- **VpnGw2AZ**: Higher throughput with AZ
- **VpnGw3AZ**: Even higher throughput with AZ

All SKUs support:
- Site-to-Site (S2S) VPN
- Point-to-Site (P2S) VPN
- VNet-to-VNet peering with transit

## Example Usage

```hcl
module "vpn_gateway" {
  source = "../../modules/networking/vpn-gateway"
  
  name             = "vpngw-hub-ne"
  location         = "northeurope"
  resource_group_name = azurerm_resource_group.hub.name
  subnet_id        = azurerm_subnet.gateway.id
  public_ip_name   = "pip-vpngw-hub-ne"
  sku              = "VpnGw1AZ"
  enable_bgp       = true
  bgp_asn          = 65515
  tags             = var.tags
}
```

## Outputs

- `gateway_id`: Resource ID
- `gateway_name`: Gateway name
- `public_ip_address`: Gateway public IP
- `bgp_settings`: BGP configuration (if enabled)
