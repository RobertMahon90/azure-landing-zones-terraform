
############################################
# Baseline policies at Root MG: AlzDemo
############################################

# Conditional policy assignments map
locals {
  policy_assignments = merge(
    {
      allowed_locations = {
        display_name         = "Allowed locations (AlzDemo)"
        policy_definition_id = var.def_allowed_locations
        parameters = jsonencode({
          listOfAllowedLocations = { value = var.allowed_locations }
        })
      }

      allowed_rg_locations = {
        display_name         = "Allowed locations for resource groups (AlzDemo)"
        policy_definition_id = var.def_allowed_rg_locations
        parameters = jsonencode({
          listOfAllowedLocations = { value = var.allowed_locations }
        })
      }

      allowed_vm_skus = {
        display_name         = "Allowed virtual machine size SKUs (AlzDemo)"
        policy_definition_id = var.def_allowed_vm_skus
        parameters = jsonencode({
          listOfAllowedSKUs = { value = var.allowed_vm_skus }
        })
      }

      not_allowed_resource_types = {
        display_name         = "Not allowed resource types (AlzDemo)"
        policy_definition_id = var.def_not_allowed_resource_types
        parameters = jsonencode({
          listOfResourceTypesNotAllowed = {
            value = var.not_allowed_resource_types
          }
        })
      }

      nic_no_public_ip = {
        display_name         = "Network interfaces should not have public IPs (AlzDemo)"
        policy_definition_id = var.def_nic_no_public_ip
        enforcement_mode     = "Default"
      }
    },
    var.deploy_cis_benchmark ? {
      cis_benchmark = {
        display_name         = "CIS Microsoft Azure Foundations Benchmark v2.0.0 (AlzDemo)"
        policy_definition_id = var.cis_benchmark_policy_set_id
        enforcement_mode     = var.compliance_enforcement_mode
      }
    } : {},
    var.deploy_mcsb_benchmark ? {
      mcsb_benchmark = {
        display_name         = "Microsoft Cloud Security Benchmark v2 (AlzDemo)"
        policy_definition_id = var.mcsb_benchmark_policy_set_id
        enforcement_mode     = var.compliance_enforcement_mode
      }
    } : {}
  )
}

module "alz_root_policies" {
  source           = "../../modules/policies"
  scope_id         = module.alz_root.id # AlzDemo MG
  policy_assignments = local.policy_assignments
}
