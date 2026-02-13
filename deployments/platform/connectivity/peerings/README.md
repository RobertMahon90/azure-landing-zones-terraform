# Connectivity - Peerings Deployment

Configures hub-to-spoke VNet peering for all platform spokes.

## Overview

This deployment establishes bidirectional network peering between the hub VNet and all spoke networks (Identity, Management, Security). Enables traffic routing and gateway transit.

## Prerequisites

- Hub VNet deployed (`connectivity`)
- All spoke networks deployed (identity, management, security)
- Spokes in separate subscriptions

## Peering Configuration

| Hub ↔ Spoke | Gateway Transit | Use Remote Gateway |
|-------------|-----------------|-------------------|
| Hub → Spoke | Allowed | N/A |
| Spoke → Hub | Disabled | Enabled |

This pattern allows spokes to route internet/on-premises traffic through hub gateways while hub provides transit capability.

## Usage

Requires provider aliases for cross-subscription access - deployment uses GitHub Actions secrets for subscription IDs.

## Outputs

- Peering resource references
- Connectivity status

## See Also

- [Connectivity README](../README.md) - Full platform deployment sequence
- [VNet Peering Module](../../../modules/networking/peering/README.md) - Module details
