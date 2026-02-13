# Backend Configuration

This directory contains Terraform backend configuration files for remote state management.

## Overview

Each `.hcl` file corresponds to a Terraform deployment and defines where state is stored:

```
backend-config/
├── connectivity.hcl              # Hub networking state
├── connectivity-bastion.hcl      # Bastion state
├── connectivity-firewall.hcl     # Firewall state
├── connectivity-vpngateway.hcl   # VPN Gateway state
├── connectivity-exrgateway.hcl   # ExpressRoute Gateway state
├── connectivity-peerings.hcl     # Hub-spoke peerings state
├── identity.hcl                  # Identity platform state
├── identity-routes.hcl           # Identity routes state
├── management.hcl                # Management platform state
├── management-routes.hcl         # Management routes state
├── security.hcl                  # Security platform state
├── security-routes.hcl           # Security routes state
├── tenant.hcl                    # Tenant-level state
├── lz-nonprod.hcl                # Non-Prod LZ state
├── lz-nonprod-routes.hcl         # Non-Prod routes state
├── lz-prod.hcl                   # Prod LZ state
└── lz-prod-routes.hcl            # Prod routes state
```

## State Storage Structure

All state files use a common storage account configured in `.hcl` files:

- **Storage Account**: Terraform state backend
- **Container**: `alzdemotfcont`
- **Keys**: Organized by layer (`platform/`, `landingzones/`, etc.)

## Workflow Usage

GitHub Actions workflow passes the appropriate `.hcl` file:

```bash
terraform init -backend-config="backend-config/connectivity.hcl"
```

## Key Values

Standard configuration across all files:

```hcl
resource_group_name  = "rg-alzdemo-tf-ne"
storage_account_name = "alzdemotfstorne"
container_name       = "alzdemotfcont"
use_azuread_auth     = true
```

Each file specifies a unique `key` for state isolation per deployment.
