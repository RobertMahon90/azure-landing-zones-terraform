# Connectivity - ExpressRoute Gateway Deployment

Deploys Azure ExpressRoute Gateway to the hub VNet for private ExpressRoute connectivity.

## Overview

This deployment creates an ExpressRoute Gateway in the hub network, enabling private, dedicated connectivity to Microsoft cloud services via ExpressRoute circuits.

## Prerequisites

- Hub VNet already deployed (`connectivity`)
- GatewaySubnet exists (10.100.1.0/27)
- ExpressRoute circuit provisioned by connectivity provider
- Gateway deployment takes 20-30 minutes

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
| `exr_gateway_name` | string | `exrgw-hub-ne` | Gateway resource name |
| `exr_sku` | string | `ERGw1Az` | SKU: ERGw1Az, ERGw2Az, ERGw3Az |

## Outputs

- `exr_gateway_id`: Gateway resource ID
- `exr_gateway_name`: Gateway resource name
- `public_ip_address`: Public IP address
- `bgp_settings`: BGP configuration details

## Remote State

Reads outputs from `platform/connectivity.tfstate`:
- Hub VNet resource group
- Hub VNet location
- GatewaySubnet ID

## Next Steps

1. Create ExpressRoute connection after gateway deployment
2. Link ExpressRoute circuit to gateway
3. Configure private peering
4. Verify connectivity from on-premises
