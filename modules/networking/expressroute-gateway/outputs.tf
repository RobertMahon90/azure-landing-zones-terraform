output "gateway_id" {
  description = "Resource ID of the ExpressRoute Gateway"
  value       = azurerm_virtual_network_gateway.exrgw.id
}

output "gateway_name" {
  description = "Name of the ExpressRoute Gateway"
  value       = azurerm_virtual_network_gateway.exrgw.name
}

output "public_ip_id" {
  description = "Public IP ID of the ExpressRoute Gateway"
  value       = azurerm_public_ip.exrgw.id
}

output "public_ip_address" {
  description = "Public IP address of the ExpressRoute Gateway"
  value       = azurerm_public_ip.exrgw.ip_address
}

output "bgp_settings" {
  description = "BGP settings of the ExpressRoute Gateway"
  value       = azurerm_virtual_network_gateway.exrgw.bgp_settings
}
