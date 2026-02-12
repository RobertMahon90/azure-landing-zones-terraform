
output "resource_group_name" {
  description = "Resource group containing the hub VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Hub VNet name"
  value       = module.hub_vnet.vnet_name
}

output "vnet_id" {
  description = "Hub VNet resource ID"
  value       = module.hub_vnet.vnet_id
}

output "address_space" {
  description = "Hub VNet address space"
  value       = ["10.100.0.0/22"]
}

output "subnet_ids" {
  description = "Map of hub subnet IDs keyed by subnet name"
  value       = module.hub_vnet.subnet_ids
}
