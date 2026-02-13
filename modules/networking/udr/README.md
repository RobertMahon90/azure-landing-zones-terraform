# User Defined Routes (UDR) Module

Deploys route tables with configurable routes for network traffic engineering.

## Overview

Creates route tables and associates them with subnets for traffic control and hybrid connectivity routing.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | - | Route table resource name |
| `location` | string | - | Azure region |
| `resource_group_name` | string | - | Target resource group |
| `tags` | map(string) | `{}` | Resource tags |

## Usage

Route table creation and route configuration typically happens at the deployment layer based on specific network topology needs.

## Example

Route traffic destined for on-premises through the firewall:

```hcl
module "udr" {
  source = "../../modules/networking/udr"
  
  name                = "udr-spoke-to-onprem"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.spoke.name
  tags                = var.tags
}

# Routes would be added separately to direct traffic through firewall/gateway
```

## Typical Routing Scenarios

- Route all internet traffic (0.0.0.0/0) through Azure Firewall
- Route on-premises subnets through VPN/ExpressRoute gateway
- Route specific services through network virtual appliances
