
output "resource_group_name" {
  description = "Resource group containing the prod spoke VNet"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Prod spoke VNet name"
  value       = module.prod_spoke_vnet.vnet_name
}

output "vnet_id" {
  description = "Prod spoke VNet resource ID"
  value       = module.prod_spoke_vnet.vnet_id
}

output "address_space" {
  description = "Prod spoke VNet address space"
  value       = ["10.104.0.0/24"]
}

output "subnet_ids" {
  description = "Map of prod spoke subnet IDs keyed by subnet name"
  value       = module.prod_spoke_vnet.subnet_ids
}
