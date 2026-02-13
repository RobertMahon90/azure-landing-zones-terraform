# Networking Modules

Reusable Terraform modules for Azure networking infrastructure.

## Available Modules

### Core Networking

| Module | Purpose |
|--------|---------|
| **vnet** | Virtual Network with configurable subnets |
| **peering** | VNet peering between hub and spokes |
| **udr** | User Defined Routes (route tables) |

### Hub Services

| Module | Purpose |
|--------|---------|
| **firewall** | Azure Firewall with policy |
| **bastion** | Azure Bastion host |
| **vpn-gateway** | VPN Gateway for site-to-site connectivity |
| **expressroute-gateway** | ExpressRoute Gateway for private connectivity |

## Module Usage Patterns

Each module follows a consistent pattern:

```hcl
module "example" {
  source = "../../modules/networking/<module-name>"
  
  # Core parameters
  name                = "resource-name"
  location            = "northeurope"
  resource_group_name = "rg-name"
  tags                = var.tags
  
  # Module-specific parameters
  # ... see module variables.tf
}
```

## Conditional Deployment

Several modules support conditional deployment via the `enabled` variable:

- **firewall**: Deploy Azure Firewall (set `enabled = false` to skip)
- **bastion**: Deploy Bastion (set `enabled = false` to skip)

This allows flexible infrastructure patterns without duplicating module code.

## State Management

Each module is stateless - the state is managed at the deployment layer. Deployments read module outputs via remote state data sources.
