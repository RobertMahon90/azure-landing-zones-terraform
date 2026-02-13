resource "azurerm_public_ip" "vpngw" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = ["1", "2", "3"]

  tags = var.tags
}

resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = var.name
  depends_on          = [azurerm_public_ip.vpngw]
  resource_group_name = var.resource_group_name
  location            = var.location

  timeouts {
    create = "2h"
    update = "2h"
    delete = "2h"
  }

  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = var.sku

  active_active       = var.enable_active_active
  enable_bgp          = var.enable_bgp

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  dynamic "bgp_settings" {
    for_each = var.enable_bgp ? [1] : []
    content {
      asn = var.bgp_asn

      dynamic "peering_addresses" {
        for_each = var.bgp_peering_address == null ? [] : [1]
        content {
          ip_configuration_name = "vnetGatewayConfig"
          apipa_addresses       = [var.bgp_peering_address]
        }
      }
    }
  }

  tags = var.tags
}
