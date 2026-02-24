# Azure Policy Module

Centralized management of Azure Policy definitions and assignments at the Management Group scope.

## Purpose

- Apply and manage Azure Policies across management group hierarchies
- Enforce organizational standards and compliance requirements
- Support both audit and enforcement modes for gradual rollout
- Enable built-in policy definitions and policy sets (initiatives)

## Module Inputs

| Variable | Type | Description |
|----------|------|-------------|
| `scope_id` | `string` | Management Group resource ID where policies are assigned |
| `policy_assignments` | `map(object)` | Map of policy assignments to create |

### Policy Assignment Object

```hcl
policy_assignments = {
  "assignment-key" = {
    display_name         = "User-friendly display name"
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/..."
    parameters           = jsonencode({ /* policy parameters */ })
    enforcement_mode     = "Default"  # or "DoNotEnforce" for audit
  }
}
```

## Policy Definitions vs. Policy Sets

### Policy Definition
Single policy rule (e.g., "Block Public IP on NICs")

```hcl
policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"
```

### Policy Set (Initiative)
Collection of related policies (e.g., CIS benchmark = 40+ individual policies)

```hcl
policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/06f19060-9e68-4070-92ca-f15cc126059e"
```

## Built-in Compliance Standards

### CIS Microsoft Azure Foundations Benchmark v2.0.0

**ID:** `06f19060-9e68-4070-92ca-f15cc126059e`

**Coverage:**
- Identity & Access Management (Azure AD)
- Azure Networking & Load Balancing
- Virtual Machines
- Storage Accounts
- Databases
- Logging & Monitoring
- Overall Security Posture

**Enable:**
```hcl
deploy_cis_benchmark = true
compliance_enforcement_mode = "Default"
```

### Microsoft Cloud Security Benchmark v1

**ID:** `1f3afdf9-d0c9-4c3d-847f-89da613e70a8`

**Coverage:**
- Network Security
- Identity & Access Management
- Data Protection
- Asset Management
- Logging & Threat Detection
- Incident Response
- Backup & Recovery
- DevOps Security
- Business Continuity
- Governance & Strategy

**Enable:**
```hcl
deploy_mcsb_benchmark = true
compliance_enforcement_mode = "Default"
```

## Enforcement Modes

| Mode | Behavior | Use Case |
|------|----------|----------|
| `Default` | Non-compliant resources are **denied** | Strict compliance enforcement |
| `DoNotEnforce` | Non-compliant resources are **logged** (audit) | Trial period / gradual rollout |

**Switch to audit mode for testing:**
```hcl
compliance_enforcement_mode = "DoNotEnforce"
```

## Deployment

### Default (Both benchmarks enabled, enforcement mode)

```bash
terraform apply
```

### CIS Only (Audit Mode)

```bash
terraform apply \
  -var="deploy_mcsb_benchmark=false" \
  -var="compliance_enforcement_mode=DoNotEnforce"
```

### Both Disabled (Customize in tfvars)

Edit `terraform.tfvars`:
```hcl
deploy_cis_benchmark = false
deploy_mcsb_benchmark = false
```

## Monitoring Compliance

After deployment, monitor policy compliance in Azure Portal:

1. Navigate to **Policy** → **Compliance**
2. Filter by Management Group scope
3. View non-compliant resources per policy
4. Drill into specific policies for remediation options

## Key Notes

- Policies inherit down the management group hierarchy (cascading)
- Compliance standards are assigned at the root management group (AlzDemo)
- Both CIS and MCSB can be toggled independently
- Use `terraform plan` to preview policy impact before `apply`
- Policy evaluation latency: ~5-15 minutes after assignment

## Remediation

For policies that support auto-remediation:
- Enable **Remediation task** in Azure Portal
- Automatically corrects non-compliant resources
- Historical compliance tracked in Activity Log

## References

- [Azure Policy Documentation](https://learn.microsoft.com/en-us/azure/governance/policy/)
- [CIS Benchmark v2.0.0 in Azure](https://learn.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0)
- [Microsoft Cloud Security Benchmark](https://learn.microsoft.com/en-us/security/benchmark/azure/)
