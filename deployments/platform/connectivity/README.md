
# Platform Connectivity (Networking)

This deployment layer defines the **core network topology** for the Azure Landing
Zone using a **hub-and-spoke model**.

## Responsibilities

This layer is responsible for:

- Hub virtual network creation
- Address space allocation
- Reserved subnets for shared network services
- Cross-subscription VNet peering
- Gateway transit configuration

The connectivity layer is **foundational** and must be deployed before any
peerings or dependent platform/workload layers.

---

## Hub Virtual Network

**Name:** `vnet-hub-ne`  
**Address Space:** `10.100.0.0/22`  
**Resource Group:** `rg-vnet-hub-ne`  

### Hub Subnets

| Subnet Name         | Address Prefix | Purpose |
|---------------------|----------------|--------|
| AzureFirewallSubnet | 10.100.0.0/26  | Azure Firewall (required name) |
| GatewaySubnet       | 10.100.1.0/27  | VPN / ExpressRoute gateway |
| AzureBastionSubnet  | 10.100.2.0/26  | Azure Bastion |

> Subnet names follow Azure service requirements and must not be changed.

---

## Spoke Virtual Networks

All spokes are deployed in dedicated subscriptions and peered to the hub.

| Spoke      | VNet Name         | Address Space | Subnet       | Subnet Prefix |
|------------|-------------------|---------------|--------------|---------------|
| Identity   | vnet-id-spk-ne    | 10.101.0.0/24 | snet-adds-ne | 10.101.0.0/26 |
| Management | vnet-mgmt-spk-ne  | 10.102.0.0/24 | snet-mgmt-ne | 10.102.0.0/26 |
| Security   | vnet-sec-spk-ne   | 10.103.0.0/24 | snet-sec-ne  | 10.103.0.0/26 |
| Prod       | vnet-prd-spk-ne   | 10.104.0.0/24 | snet-prd-ne  | 10.104.0.0/26 |
| Non-Prod   | vnet-nprod-spk-ne | 10.105.0.0/24 | snet-nprd-ne | 10.105.0.0/26 |

Each spoke is deployed using an independent Terraform state to maintain strict
separation of responsibility and blast radius.

---

## VNet Peering

Peering is managed via a **dedicated deployment**:
