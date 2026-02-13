# Connectivity - Azure Firewall Deployment

Deploys Azure Firewall and Firewall Policy to the hub VNet for centralized network protection.

## Overview

This deployment creates Azure Firewall as a central security control point in the hub network. All spoke traffic can route through the firewall for inspection and policy enforcement.

## Prerequisites

- Hub VNet already deployed (`connectivity`)
- AzureFirewallSubnet exists (10.100.0.0/26)

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
| `deploy_firewall` | bool | `true` | Deploy Firewall when true |
| `firewall_name` | string | `azfw-hub-ne` | Firewall resource name |
| `firewall_policy_name` | string | `azfw-hub-policy-ne` | Policy resource name |
| `firewall_sku_tier` | string | `Standard` | Tier: Standard or Premium |

## Outputs

- `firewall_id`: Firewall resource ID
- `firewall_name`: Firewall resource name
- `firewall_private_ip`: Internal IP address
- `firewall_public_ip_address`: Public IP address
- `firewall_policy_id`: Policy resource ID

## Remote State

Reads outputs from `platform/connectivity.tfstate`:
- Hub VNet resource group
- Hub VNet location
- AzureFirewallSubnet ID

## Next Steps

After deployment, configure firewall rules in the Firewall Policy resource.
