# Connectivity - Bastion Deployment

Deploys Azure Bastion to the hub VNet for secure VM access.

## Overview

This deployment creates an Azure Bastion host in the hub network, providing RDP/SSH access to VMs without exposing public IPs or management ports.

## Prerequisites

- Hub VNet already deployed (`connectivity`)
- AzureBastionSubnet exists (10.100.2.0/26)

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
| `deploy_bastion` | bool | `true` | Deploy Bastion when true |
| `bastion_name` | string | `bastion-hub-ne` | Bastion resource name |
| `bastion_sku` | string | `Basic` | SKU: Basic or Standard |

## Outputs

- `bastion_id`: Bastion resource ID
- `bastion_name`: Bastion resource name
- `bastion_public_ip`: Public IP address

## Remote State

Reads outputs from `platform/connectivity.tfstate`:
- Hub VNet resource group
- Hub VNet location
- AzureBastionSubnet ID
