location = "northeurope"

def_allowed_locations          = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
def_allowed_rg_locations       = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
def_allowed_vm_skus            = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"
def_not_allowed_resource_types = "/providers/Microsoft.Authorization/policyDefinitions/6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
def_nic_no_public_ip           = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"

# Compliance Standards
deploy_cis_benchmark           = true
deploy_mcsb_benchmark          = true
compliance_enforcement_mode    = "Default"

# Service Health Alerts
alert_email                = "robert.mahon@eirbusiness.ie"
alert_built_date           = "2026-02-25"
alert_created_by           = "eir business"

# Subscription IDs for each tier (update with actual values)
subscription_id_management   = "REPLACE_WITH_MGMT_SUB_ID"
subscription_id_security     = "REPLACE_WITH_SEC_SUB_ID"
subscription_id_connectivity = "REPLACE_WITH_CONN_SUB_ID"
subscription_id_identity     = "REPLACE_WITH_ID_SUB_ID"
subscription_id_lz_prod      = "REPLACE_WITH_PROD_SUB_ID"
subscription_id_lz_nonprod   = "REPLACE_WITH_NONPROD_SUB_ID"
