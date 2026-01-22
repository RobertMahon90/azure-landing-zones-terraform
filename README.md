# azure-landing-zones-terraform
ALZ Terraform


## Management Group Hierarchy (as code)

Tenant Root Group  
└── AlzDemo  
&nbsp;&nbsp;&nbsp;&nbsp;├── Platform  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Identity  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Connectivity  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├── Management  
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;└── Security  
&nbsp;&nbsp;&nbsp;&nbsp;└── Landing Zones  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── Prod  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── Non-Prod


## Networking Architecture

This repository implements a **hub-and-spoke networking model** aligned with
Azure Landing Zones and enterprise network segmentation best practices.

### Design Summary

- A single **Connectivity (Hub) virtual network** provides shared network services.
- Multiple **Spoke virtual networks** host platform and workload resources.
- All spokes are **peered to the hub**.
- **Gateway transit is enabled**, allowing spokes to route through hub gateways.
- Spoke-to-spoke traffic is mediated via the hub.

Networking is deployed and managed as **separate Terraform layers** with
independent state files.

### High-Level Topology
