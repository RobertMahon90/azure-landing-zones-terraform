# Azure Landing Zones - Terraform Implementation

Enterprise-grade Azure infrastructure as code implementing the Azure Landing Zones (ALZ) framework. This repository provides a modular, scalable foundation for multi-subscription Azure environments with hub-and-spoke networking, governance policies, and automated deployments.

## Key Features

- **Hub-and-Spoke Architecture**: Centralized connectivity hub with platform and workload spokes
- **Modular Components**: Independent Terraform deployments for each infrastructure layer
- **Conditional Deployments**: Optional services (Bastion, Firewall, VPN/ExpressRoute Gateways) controlled via variables
- **Multi-Subscription Support**: Separate state backends and GitHub Actions targeting per subscription
- **Network Security**: Azure Firewall with integrated policy, Bastion access, dual gateway options
- **Management Groups**: Organizational hierarchy with subscription delegation
- **Policy as Code**: Azure Policies for compliance and governance
- **GitOps Ready**: GitHub Actions workflows for automated infrastructure deployment

## Repository Structure

```
deployments/platform/connectivity/
  ├── main.tf                  # Core hub network
  ├── bastion/                 # Optional Bastion deployment
  ├── firewall/                # Optional Firewall + policy deployment
  ├── vpngateway/              # Optional VPN Gateway deployment
  ├── exrgateway/              # Optional ExpressRoute Gateway deployment  
  ├── peerings/                # Hub-to-spoke peering
  └── routes/                  # Route table configuration

modules/networking/
  ├── bastion/                 # Bastion module
  ├── firewall/                # Firewall + policy module
  ├── vpn-gateway/             # VPN Gateway module
  ├── expressroute-gateway/    # ExpressRoute Gateway module
  ├── vnet/                    # VNet module
  ├── peering/                 # VNet peering module
  └── udr/                     # User Defined Routes module

backend-config/               # Terraform state backend configs per layer
```
## Management Group Hierarchy (as code)

Tenant Root Group  
└── AlzDemo  
&nbsp;&nbsp;&nbsp;&nbsp;├── Platform  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Identity  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Connectivity  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Management  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;└── Security  
&nbsp;&nbsp;&nbsp;&nbsp;└── Landing Zones  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ├── Prod  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; └── Non-Prod


## Hub-and-Spoke Network Architecture

**Core Design:**
- Hub VNet provides centralized connectivity and security services
- Spoke VNets (Identity, Management, Security, Prod, Non-Prod) host workloads
- All spokes peered to hub with gateway transit enabled
- Spoke-to-spoke traffic flows through hub for centralized inspection
- Independent Terraform state files per deployment layer

```
                                  +-------------------------------+
                                  |            HUB VNET           |
                                  |          10.100.0.0/22        |
                                  +-------------------------------+
                                  | Azure Firewall (Std/Prem)     |
                                  | Gateway (VPN/ER - optional)   |
                                  | Bastion (optional)            |
                                  +---------------+---------------+
                                                  |
                                    VNet Peering (Hub <-> Spokes)
                                                  |
+-----------------+  +-----------------+  +-----------------+  +-----------------+ +-----------------+ 
|  Identity VNET  |  |    MGMT VNET    |  |  Security VNET  |  |    Prod VNET    | |  Non-Prod VNET  |
|  10.101.0.0/24  |  |  10.102.0.0/24  |  |  10.103.0.0/24  |  |  10.104.0.0/24  | |  10.105.0.0/24  |
+-----------------+  +-----------------+  +-----------------+  +-----------------+ +-----------------+
```

## Deployment Layers (7 Independent State Files)

| Layer | Location | Purpose |
|-------|----------|---------|
| Hub Network | `platform/connectivity/` | Core VNet + subnets |
| Bastion | `platform/connectivity/bastion/` | Secure RDP (optional) |
| Firewall | `platform/connectivity/firewall/` | Network inspection + policy (Optional) |
| VPN Gateway | `platform/connectivity/vpngateway/` | Hybrid site-to-site (Optional)|
| ExpressRoute Gateway | `platform/connectivity/exrgateway/` | Private circuit connectivity (Optional) |
| Peerings | `platform/connectivity/peerings/` | Hub-to-spoke relationships |
| Routes | `platform/connectivity/routes/` | Route tables & UDRs |

## Quick Start

### Prerequisites

- Terraform >= 1.6
- Azure CLI (authenticated)
- Azure Storage Account (for remote state)
- Subscriptions for target deployments

### Deploy Hub Network

```bash
cd deployments/platform/connectivity
terraform init -backend-config=../../backend-config/connectivity.hcl
terraform plan
terraform apply
```

### Deploy Optional Services

```bash
# Firewall with integrated policy
cd firewall
terraform init -backend-config=../../backend-config/connectivity-firewall.hcl
terraform plan -var="deploy_firewall=true"
terraform apply

# Bastion for secure access
cd ../bastion
terraform init -backend-config=../../backend-config/connectivity-bastion.hcl
terraform plan -var="deploy_bastion=true"
terraform apply

# VPN Gateway for hybrid connectivity
cd ../vpngateway
terraform init -backend-config=../../backend-config/connectivity-vpngateway.hcl
terraform plan
terraform apply

# ExpressRoute Gateway for private circuits
cd ../exrgateway
terraform init -backend-config=../../backend-config/connectivity-exrgateway.hcl
terraform plan
terraform apply
```

### GitHub Actions Deployment

Workflow supports automated multi-subscription deployments:
- Targets: `connectivity`, `connectivity-bastion`, `connectivity-firewall`, `connectivity-vpngateway`, `connectivity-exrgateway`, `connectivity-peerings`, `connectivity-routes`
- File: `.github/workflows/terraform-alz-multi-sub.yml`
- Push to main branch or manually trigger workflow

## Key Components

### Azure Firewall (Optional)

- **Module**: `modules/networking/firewall/`
- **Deployment**: `deployments/platform/connectivity/firewall/`
- **SKU**: Standard (Premium available)
- **Features**: Integrated firewall policy, centralized inspection
- **Subnet**: AzureFirewallSubnet (10.100.0.0/26)

### Bastion (Optional)

- **Module**: `modules/networking/bastion/`
- **Deployment**: `deployments/platform/connectivity/bastion/`
- **SKU**: Basic (Standard available)
- **Features**: Secure shell without port exposure
- **Subnet**: AzureBastionSubnet (10.100.1.32/27)

### VPN Gateway (Optional)

- **Module**: `modules/networking/vpn-gateway/`
- **Deployment**: `deployments/platform/connectivity/vpngateway/`
- **Type**: Route-based VPN (IKEv2/IPSec)
- **SKU**: VpnGw1AZ (VpnGw2AZ, VpnGw3AZ available)
- **Features**: BGP support, active-active capable
- **Subnet**: GatewaySubnet (10.100.1.0/27)

### ExpressRoute Gateway (Optional)

- **Module**: `modules/networking/expressroute-gateway/`
- **Deployment**: `deployments/platform/connectivity/exrgateway/`
- **Type**: ExpressRoute (private dedicated circuit)
- **SKU**: ERGw1Az (ERGw2Az, ERGw3Az available)
- **Features**: BGP required, Microsoft Peering support
- **Subnet**: GatewaySubnet (10.100.1.0/27)

## Remote State Integration

Each deployment reads upstream state for dependencies:

```hcl
data "terraform_remote_state" "hub" {
  backend = "azurerm"
  config = {
    resource_group_name  = "alz-state-rg"
    storage_account_name = "alzstatestg"
    container_name       = "tfstate"
    key                  = "platform/connectivity.tfstate"
  }
}

module "firewall" {
  source = "../../../modules/networking/firewall"
  subnet_id = data.terraform_remote_state.hub.outputs.firewall_subnet_id
}
```

## Documentation

- [Platform Layer Overview](deployments/platform/README.md)
- [Networking Modules](modules/networking/README.md)
- [Backend Configuration](backend-config/README.md)
- [Module Details](modules/networking/[module]/README.md)
- [Deployment Guides](deployments/platform/connectivity/[layer]/README.md)

## Configuration

### Enable/Disable Services

Control deployment via variables:

```hcl
# Bastion
deploy_bastion = true    # false to skip

# Firewall  
deploy_firewall = true   # false to skip

# VPN
vpn_enabled = true       # false to skip

# ExpressRoute
exr_enabled = true       # false to skip
```

### Network CIDR Blocks

Hub VNet: 10.100.0.0/22
- AzureFirewallSubnet: 10.100.0.0/26
- GatewaySubnet: 10.100.1.0/27
- AzureBastionSubnet: 10.100.1.32/27

- Identity Spoke: 10.101.0.0/24
- Management Spoke: 10.102.0.0/24
- Security Spoke: 10.103.0.0/24
- Prod Landing Zone: 10.200.0.0/22
- Non-Prod Landing Zone: 10.201.0.0/22

## Troubleshooting

**Remote state not found**: Ensure upstream layers deployed first (hub → peerings → optional services)

**Backend authentication fails**: Verify storage account credentials and AZURE_* environment variables

**Peering conflicts**: Check CIDR overlaps with `az network vnet show` and `az network vnet peering list`

## Support

Refer to component-specific README files in modules/ and deployments/ directories for detailed guidance.

---

Terraform >= 1.6 | Azure Provider >= 3.110 | ALZ Framework

