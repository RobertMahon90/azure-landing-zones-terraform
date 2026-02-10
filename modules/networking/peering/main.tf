terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

      # This tells Terraform the module expects provider aliases from the caller
      configuration_aliases = [azurerm.hub, azurerm.spoke]
    }
  }
}

# Hub -> Spoke peering (created in hub subscription)
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  provider = azurerm.hub

  name                 = var.hub_peering_name
  resource_group_name  = var.hub_resource_group_name
  virtual_network_name = var.hub_virtual_network_name

  remote_virtual_network_id = var.spoke_vnet_id

  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
}

# Spoke -> Hub peering (created in spoke subscription)
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  provider = azurerm.spoke

  name                 = var.spoke_peering_name
  resource_group_name  = var.spoke_resource_group_name
  virtual_network_name = var.spoke_virtual_network_name

  remote_virtual_network_id = var.hub_vnet_id

  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = false
  use_remote_gateways          = var.use_remote_gateways
}
