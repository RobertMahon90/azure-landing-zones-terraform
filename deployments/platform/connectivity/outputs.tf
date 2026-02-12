
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

output "bastion_id" {
  description = "Resource ID of the hub Bastion host"
  value       = module.hub_bastion.bastion_id
}

output "bastion_name" {
  description = "Name of the hub Bastion host"
  value       = module.hub_bastion.bastion_name
}

output "bastion_public_ip" {
  description = "Public IP address of the hub Bastion host"
  value       = module.hub_bastion.public_ip_address
}
