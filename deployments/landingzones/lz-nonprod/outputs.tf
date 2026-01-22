
output "resource_group_name" {
  description = "Resource group containing the non-prod spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Non-prod spoke VNet name"
  value       = module.nonprod_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Non-prod spoke VNet resource ID"
  value       = module.nonprod_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Non-prod spoke VNet address space"
  value       = ["10.105.0.0/24"]
}

output "subnet_ids" {
  description = "Map of non-prod spoke subnet IDs keyed by subnet name"
  value       = module.nonprod_spoke_vnet.subnet_ids
}
