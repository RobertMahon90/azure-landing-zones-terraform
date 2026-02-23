# Connectivity Routes

This directory contains route table (UDR) deployments for the connectivity hub spoke and associated spokes. Route tables are modelled separately so they can be deployed after VNets and peerings are available.

## Purpose

- Create and manage User Defined Routes (UDRs) and route tables for hub and spoke networks
- Enable forced tunnelling via firewall/NVA
- Assign route tables to subnets as required

## Structure

```
deployments/platform/connectivity/routes/
├── main.tf
├── variables.tf
└── outputs.tf
```

## Quick Start

```bash
cd deployments/platform/connectivity/routes
terraform init -backend-config=../../backend-config/connectivity-routes.hcl
terraform plan
terraform apply
```

## Notes

- Route table deployments depend on upstream VNets and remote-state outputs from `platform/connectivity` and per-spoke deployments.
- Tags are applied using `modules/tags_alz` and can be customised via variables.
