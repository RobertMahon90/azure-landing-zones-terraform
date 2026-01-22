
output "hub_to_spoke_id" {
  value       = azurerm_virtual_network_peering.hub_to_spoke.id
  description = "Hub-to-spoke peering ID"
}

output "spoke_to_hub_id" {
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
  description = "Spoke-to-hub peering ID"
}
