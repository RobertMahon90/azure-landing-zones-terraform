output "firewall_id" {
  description = "Resource ID of the hub Azure Firewall"
  value       = module.hub_firewall.firewall_id
}

output "firewall_name" {
  description = "Name of the hub Azure Firewall"
  value       = module.hub_firewall.firewall_name
}

output "firewall_private_ip" {
  description = "Private IP address of the hub Azure Firewall"
  value       = module.hub_firewall.firewall_private_ip
}

output "firewall_public_ip_id" {
  description = "Public IP ID of the Azure Firewall"
  value       = module.hub_firewall.public_ip_id
}

output "firewall_public_ip_address" {
  description = "Public IP address of the Azure Firewall"
  value       = module.hub_firewall.public_ip_address
}
