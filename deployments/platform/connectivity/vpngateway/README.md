# Connectivity - VPN Gateway Deployment

Deploys Azure VPN Gateway to the hub VNet for site-to-site and point-to-site connectivity.

## Overview

This deployment creates a VPN Gateway in the hub network, enabling hybrid connectivity from on-premises networks and remote point-to-site access.

## Prerequisites

- Hub VNet already deployed (`connectivity`)
- GatewaySubnet exists (10.100.1.0/27)
- VPN Gateway deployment takes 20-30 minutes

## Usage

### Plan

```bash
terraform plan -var "subscription_id=<connectivity-sub-id>"
```

### Apply

```bash
terraform apply -var "subscription_id=<connectivity-sub-id>"
```

## Configuration

| Variable | Type | Default | Purpose |
|----------|------|---------|---------|
| `vpn_gateway_name` | string | `vpngw-hub-ne` | Gateway resource name |
| `vpn_sku` | string | `VpnGw1AZ` | SKU: VpnGw1AZ, VpnGw2AZ, VpnGw3AZ |
| `enable_bgp` | bool | `false` | Enable BGP |
| `enable_active_active` | bool | `false` | Active-Active configuration |

## Outputs

- `vpn_gateway_id`: Gateway resource ID
- `vpn_gateway_name`: Gateway resource name
- `public_ip_address`: Public IP address
- `bgp_settings`: BGP configuration (if enabled)

## Remote State

Reads outputs from `platform/connectivity.tfstate`:
- Hub VNet resource group
- Hub VNet location
- GatewaySubnet ID

## Next Steps

1. Create VPN connections after gateway deployment
2. Configure local network gateways for on-premises sites
3. Create site-to-site or point-to-site connections
