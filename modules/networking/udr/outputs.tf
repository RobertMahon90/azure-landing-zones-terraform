
output "route_table_id" {
  description = "Route table resource ID"
  value       = azurerm_route_table.this.id
}

output "route_ids" {
  description = "Route IDs"
  value       = { for k, v in azurerm_route.this : k => v.id }
}
