
############################################
# Baseline policies at Root MG: AlzDemo
############################################

module "alz_root_policies" {
  source   = "../../modules/policies"
  scope_id = module.alz_root.id

  policy_assignments = {

    # 1) Allowed Locations (all resources)
    allowed_locations = {
      display_name         = "Allowed locations (AlzDemo)"
      policy_definition_id = var.def_allowed_locations
      parameters = jsonencode({
        listOfAllowedLocations = {
          value = var.allowed_locations
        }
      })
    }

    # 2) Allowed Locations for Resource Groups
    allowed_rg_locations = {
      display_name         = "Allowed locations for resource groups (AlzDemo)"
      policy_definition_id = var.def_allowed_rg_locations
      parameters = jsonencode({
        listOfAllowedLocations = {
          value = var.allowed_locations
        }
      })
    }

    # 3) Allowed VM Size SKUs
    allowed_vm_skus = {
      display_name         = "Allowed virtual machine size SKUs (AlzDemo)"
      policy_definition_id = var.def_allowed_vm_skus
      parameters = jsonencode({
        listOfAllowedSKUs = {
          value = var.allowed_vm_skus
        }
      })
    }

    # 4) Not Allowed Resource Types (e.g., deny DDoS Standard)
    not_allowed_resource_types = {
      display_name         = "Not allowed resource types (AlzDemo)"
      policy_definition_id = var.def_not_allowed_resource_types
      parameters = jsonencode({
        listOfResourceTypesNotAllowed = {
          value = var.not_allowed_resource_types
        }
      })
    }

    # 5) NICs should not have Public IPs
    nic_no_public_ip = {
      display_name         = "Network interfaces should not have public IPs (AlzDemo)"
      policy_definition_id = var.def_nic_no_public_ip
      enforcement_mode     = "Default"
    }
  }
}
