output "vpn_gateway_id" {
  description = "VPN gateway resource ID"
  value       = module.hub_vpn_gateway.gateway_id
}

output "vpn_gateway_name" {
  description = "VPN gateway name"
  value       = module.hub_vpn_gateway.gateway_name
}

output "public_ip_id" {
  description = "Public IP resource ID for the VPN gateway"
  value       = module.hub_vpn_gateway.public_ip_id
}

output "public_ip_address" {
  description = "Public IP address for the VPN gateway"
  value       = module.hub_vpn_gateway.public_ip_address
}

output "bgp_settings" {
  description = "BGP settings for the VPN gateway"
  value       = module.hub_vpn_gateway.bgp_settings
}
