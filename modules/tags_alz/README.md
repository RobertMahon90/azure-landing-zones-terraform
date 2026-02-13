# ALZ Tagging Module

Standardized tagging module for Azure Landing Zones deployments. Provides consistent tag format across resource groups and resources.

## Overview

This module implements the ALZ tagging strategy with two levels:

1. **Resource Group Level** - Metadata for the RG as a whole
2. **Resource Level** - Metadata for individual resources within the RG

## Tag Structure

Both levels use the same tags with context-appropriate values:

| Tag | Purpose | Example |
|-----|---------|---------|
| `Tier` | Deployment environment | `Prod`, `Non-Prod`, `Dev` |
| `Service` | Service/component name | `Azure Networking`, `Log Analytics`, `Virtual Network` |
| `Built` | ISO date when created | `2026-02-13` |
| `CreatedBy` | Organization/team | `eir business` |

## Usage

### Resource Group Tagging

```hcl
module "tags" {
  source            = "../../../modules/tags_alz"
  tier              = var.tier
  rg_service        = "Azure Networking"
  resource_service  = "Virtual Network"
  built_date        = var.built_date
  created_by        = var.created_by
}

resource "azurerm_resource_group" "management_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = module.tags.rg_tags  # Resource group level tags
}
```

### Resource Level Tagging

```hcl
resource "azurerm_virtual_network" "management_vnet" {
  name                = "vnet-mgmt-ne"
  resource_group_name = azurerm_resource_group.management_rg.name
  tags                = module.tags.resource_tags  # Individual resource tags
}
```

## Parameters

| Variable | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `tier` | string | Yes | - | Deployment tier: `Prod`, `Non-Prod`, or `Dev` |
| `rg_service` | string | Yes | - | Service name for resource group |
| `resource_service` | string | Yes | - | Resource/service type (e.g., Virtual Network, Bastion, Firewall) |
| `built_date` | string | No | Current date | ISO 8601 date (YYYY-MM-DD) |
| `created_by` | string | No | `eir business` | Organization/team name |

## Examples

### Networking Deployment

```hcl
module "tags" {
  source            = "../../../modules/tags_alz"
  tier              = "Prod"
  rg_service        = "Azure Networking"
  resource_service  = "Virtual Network"
  built_date        = "2026-02-13"
  created_by        = "eir business"
}

# Output:
# rg_tags = {
#   Tier      = "Prod"
#   Service   = "Azure Networking"
#   Built     = "2026-02-13"
#   CreatedBy = "eir business"
# }
#
# resource_tags = {
#   Tier      = "Prod"
#   Service   = "Virtual Network"
#   Built     = "2026-02-13"
#   CreatedBy = "eir business"
# }
```

### Monitoring Deployment

```hcl
module "tags" {
  source            = "../../../modules/tags_alz"
  tier              = "Non-Prod"
  rg_service        = "Azure Monitoring"
  resource_service  = "Log Analytics"
  built_date        = "2026-02-13"
  created_by        = "eir business"
}

# Output:
# rg_tags = {
#   Tier      = "Non-Prod"
#   Service   = "Azure Monitoring"
#   Built     = "2026-02-13"
#   CreatedBy = "eir business"
# }
#
# resource_tags = {
#   Tier      = "Non-Prod"
#   Service   = "Log Analytics"
#   Built     = "2026-02-13"
#   CreatedBy = "eir business"
# }
```

### Firewall Deployment

```hcl
module "tags" {
  source            = "../../../modules/tags_alz"
  tier              = "Prod"
  rg_service        = "Azure Networking"
  resource_service  = "Firewall"
  built_date        = "2026-02-13"
}

# resource_tags will have Service = "Firewall"
```

### Bastion Deployment

```hcl
module "tags" {
  source            = "../../../modules/tags_alz"
  tier              = "Prod"
  rg_service        = "Azure Networking"
  resource_service  = "Bastion"
  built_date        = "2026-02-13"
}

# resource_tags will have Service = "Bastion"
```

## Outputs

| Output | Description |
|--------|-------------|
| `rg_tags` | Tags object for resource groups |
| `resource_tags` | Tags object for individual resources |

## Notes

- All tag keys use PascalCase for clarity
- Tag values use Title Case (e.g., "Prod", "Non-Prod", "Dev")
- The `built_date` defaults to current date if not specified
- Tags are consistent and searchable across all deployments
- Use `Tier` to filter resources by environment in Azure Portal

## Filtering Examples

**Azure CLI:**
```bash
# Find all Prod resources
az resource list --query "[?tags.Tier=='Prod']"

# Find all Firewall resources
az resource list --query "[?tags.Service=='Firewall']"

# Find resources built on specific date
az resource list --query "[?tags.Built=='2026-02-13']"
```

**Azure Portal:**
- Filter by `Tier: Prod` to see production resources
- Filter by `Service: Azure Networking` to see network resources
- Filter by `CreatedBy: eir business` for audit trail
