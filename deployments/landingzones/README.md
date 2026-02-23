# Landing Zone Deployments

This directory contains landing zone deployments that host workload infrastructure. Each landing zone is modelled as an independent Terraform deployment so it can be managed, versioned, and scoped to its own subscription and state file.

## Structure

```
deployments/landingzones/
├── lz-prod/        # Production landing zone
│   ├── main.tf
│   ├── variables.tf
│   └── routes/
└── lz-nonprod/     # Non-production landing zone
  ├── main.tf
  ├── variables.tf
  └── routes/
```

## Deployment Overview

| Component | Purpose | State File |
|-----------|---------|------------|
| **lz-prod** | Production landing zone (spoke VNet + baseline services) | `landingzones/lz-prod.tfstate` |
| **lz-nonprod** | Non-production landing zone (spoke VNet + baseline services) | `landingzones/lz-nonprod.tfstate` |
| **routes** | Route tables / UDRs for each landing zone | `landingzones/<lz>-routes.tfstate` |

## Deployment Sequence

1. Deploy platform connectivity (hub) first.
2. Deploy optional platform services (firewall, gateways) if required.
3. Deploy landing zones (`lz-prod`, `lz-nonprod`) to create spoke VNets and resource groups.
4. Deploy landing zone route tables (`routes/`) after spokes exist (optional).

## Key Features

- **Isolated State**: Each landing zone uses its own Terraform state for independent lifecycle management.
- **Hub Integration**: Landing zones read hub outputs via `terraform_remote_state` to integrate with shared services (peering, gateways).
- **Consistent Tagging**: Resources are tagged via the `modules/tags_alz` module; override `tier`, `built_date`, and `created_by` via variables.
- **Baseline Security**: Spoke VNets include NSGs and route table integration as part of the baseline.

## Quick Start

```bash
cd deployments/landingzones/lz-prod
terraform init -backend-config=../../backend-config/lz-prod.hcl
terraform plan
terraform apply

cd ../lz-nonprod
terraform init -backend-config=../../backend-config/lz-nonprod.hcl
terraform plan
terraform apply
```

## Notes

- Ensure the hub (`deployments/platform/connectivity`) is deployed before landing zones so remote state outputs are available.
- Routes and UDRs are optional and can be deployed after spokes are created.
- See `modules/networking/vnet` for the VNet module used by landing zones.

