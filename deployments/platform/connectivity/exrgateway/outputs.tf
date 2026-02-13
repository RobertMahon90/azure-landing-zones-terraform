output "exr_gateway_id" {
  description = "ExpressRoute gateway resource ID"
  value       = module.hub_expressroute_gateway.gateway_id
}

output "exr_gateway_name" {
  description = "ExpressRoute gateway name"
  value       = module.hub_expressroute_gateway.gateway_name
}

output "public_ip_id" {
  description = "Public IP resource ID for the ExpressRoute gateway"
  value       = module.hub_expressroute_gateway.public_ip_id
}

output "public_ip_address" {
  description = "Public IP address for the ExpressRoute gateway"
  value       = module.hub_expressroute_gateway.public_ip_address
}

output "bgp_settings" {
  description = "BGP settings for the ExpressRoute gateway"
  value       = module.hub_expressroute_gateway.bgp_settings
}
