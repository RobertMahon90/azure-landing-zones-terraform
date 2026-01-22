
output "resource_group_name" {
  description = "Resource group containing the identity spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Identity spoke VNet name"
  value       = module.identity_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Identity spoke VNet resource ID"
  value       = module.identity_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Identity spoke VNet address space"
  value       = ["10.101.0.0/24"]
}

output "subnet_ids" {
  description = "Map of identity spoke subnet IDs keyed by subnet name"
  value       = module.identity_spoke_vnet.subnet_ids
}
