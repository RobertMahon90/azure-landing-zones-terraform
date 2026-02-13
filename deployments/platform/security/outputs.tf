
output "resource_group_name" {
  description = "Resource group containing the security spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Security spoke VNet name"
  value       = module.security_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Security spoke VNet resource ID"
  value       = module.security_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Security spoke VNet address space"
  value       = ["10.103.0.0/24"]
}

output "subnet_ids" {
  description = "Map of security spoke subnet IDs keyed by subnet name"
  value       = module.security_spoke_vnet.subnet_ids
}
