output "gateway_id" {
  description = "Resource ID of the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vpngw.id
}

output "gateway_name" {
  description = "Name of the VPN Gateway"
  value       = azurerm_virtual_network_gateway.vpngw.name
}

output "public_ip_id" {
  description = "Public IP ID of the VPN Gateway"
  value       = azurerm_public_ip.vpngw.id
}

output "public_ip_address" {
  description = "Public IP address of the VPN Gateway"
  value       = azurerm_public_ip.vpngw.ip_address
}

output "bgp_settings" {
  description = "BGP settings of the VPN Gateway"
  value       = var.enable_bgp ? azurerm_virtual_network_gateway.vpngw.bgp_settings : null
}
