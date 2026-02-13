# Platform Deployments

This directory contains all platform infrastructure as code deployments for the Azure Landing Zone.

## Structure

```
platform/
├── connectivity/          # Hub network and shared services
├── identity/              # Identity and governance platform
├── management/            # Monitoring and management platform
└── security/              # Security and compliance platform
```

## Deployment Overview

| Component | Purpose | State File |
|-----------|---------|-----------|
| **connectivity** | Hub VNet, shared network services | `platform/connectivity.tfstate` |
| **connectivity-bastion** | Azure Bastion for hub | `platform/connectivity-bastion.tfstate` |
| **connectivity-firewall** | Azure Firewall for hub | `platform/connectivity-firewall.tfstate` |
| **connectivity-vpngateway** | VPN Gateway for hybrid connectivity | `platform/connectivity-vpngateway.tfstate` |
| **connectivity-exrgateway** | ExpressRoute Gateway for ExpressRoute | `platform/connectivity-exrgateway.tfstate` |
| **connectivity-peerings** | Hub-to-spoke VNet peerings | `platform/connectivity-peerings.tfstate` |
| **identity** | Identity platform spoke network | `platform/identity.tfstate` |
| **identity-routes** | Route tables for identity spoke | `platform/identity-routes.tfstate` |
| **management** | Management platform spoke network | `platform/management.tfstate` |
| **management-routes** | Route tables for management spoke | `platform/management-routes.tfstate` |
| **security** | Security platform spoke network | `platform/security.tfstate` |
| **security-routes** | Route tables for security spoke | `platform/security-routes.tfstate` |

## Deployment Sequence

1. **connectivity** - Deploy hub VNet first (foundation)
2. **connectivity-firewall** - Deploy Azure Firewall (optional)
3. **connectivity-vpngateway** OR **connectivity-exrgateway** - Deploy gateway (optional)
4. **connectivity-bastion** - Deploy Bastion (optional)
5. **identity**, **management**, **security** - Deploy spokes (parallel)
6. **connectivity-peerings** - Configure peerings after spokes exist
7. **identity-routes**, **management-routes**, **security-routes** - Deploy route tables (optional)

## Key Features

- **Modular Design**: Each component is independent and can be deployed separately
- **Remote State Integration**: Deployments read outputs from upstream layers
- **Multiple Subscriptions**: Each platform component in dedicated subscription
- **Gateway Transit**: Hub supports gateway transit for hybrid connectivity
- **Conditional Deployment**: Firewall, Bastion, and Gateways are optional
