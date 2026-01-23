
output "vpn_gateway_id" {
  description = "VPN gateway resource ID"
  value       = azurerm_virtual_network_gateway.vpngw.id
}

output "vpn_gateway_name" {
  description = "VPN gateway name"
  value       = azurerm_virtual_network_gateway.vpngw.name
}

output "public_ip_id" {
  description = "Public IP resource ID for the VPN gateway"
  value       = azurerm_public_ip.vpngw.id
}

output "public_ip_address" {
  description = "Public IP address for the VPN gateway"
  value       = azurerm_public_ip.vpngw.ip_address
}
