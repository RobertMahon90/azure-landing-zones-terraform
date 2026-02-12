output "bastion_id" {
  description = "Resource ID of the Bastion host"
  value       = try(azurerm_bastion_host.this[0].id, null)
}

output "bastion_name" {
  description = "Name of the Bastion host"
  value       = try(azurerm_bastion_host.this[0].name, null)
}

output "public_ip_id" {
  description = "Public IP ID of the Bastion host"
  value       = try(azurerm_public_ip.bastion[0].id, null)
}

output "public_ip_address" {
  description = "Public IP address of the Bastion host"
  value       = try(azurerm_public_ip.bastion[0].ip_address, null)
}
