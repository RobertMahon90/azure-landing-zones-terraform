
output "resource_group_name" {
  description = "Resource group containing the management spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Management spoke VNet name"
  value       = module.management_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Management spoke VNet resource ID"
  value       = module.management_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Management spoke VNet address space"
  value       = ["10.102.0.0/24"]
}

output "subnet_ids" {
  description = "Map of management spoke subnet IDs keyed by subnet name"
  value       = module.management_spoke_vnet.subnet_ids
}
