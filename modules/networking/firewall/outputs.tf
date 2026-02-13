output "firewall_id" {
  description = "Resource ID of the Azure Firewall"
  value       = try(azurerm_firewall.this[0].id, null)
}

output "firewall_name" {
  description = "Name of the Azure Firewall"
  value       = try(azurerm_firewall.this[0].name, null)
}

output "firewall_private_ip" {
  description = "Private IP address of the Azure Firewall"
  value       = try(azurerm_firewall.this[0].ip_configuration[0].private_ip_address, null)
}

output "public_ip_id" {
  description = "Public IP ID of the Azure Firewall"
  value       = try(azurerm_public_ip.firewall[0].id, null)
}

output "public_ip_address" {
  description = "Public IP address of the Azure Firewall"
  value       = try(azurerm_public_ip.firewall[0].ip_address, null)
}

output "firewall_policy_id" {
  description = "Resource ID of the Azure Firewall Policy"
  value       = try(azurerm_firewall_policy.this[0].id, null)
}

output "firewall_policy_name" {
  description = "Name of the Azure Firewall Policy"
  value       = try(azurerm_firewall_policy.this[0].name, null)
}
