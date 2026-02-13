resource "azurerm_public_ip" "exrgw" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method       = "Static"
  sku                     = "Standard"
  zones                   = ["1", "2", "3"]

  tags = var.tags
}

resource "azurerm_virtual_network_gateway" "exrgw" {
  name                = var.name
  depends_on          = [azurerm_public_ip.exrgw]
  resource_group_name = var.resource_group_name
  location            = var.location

  timeouts {
    create = "2h"
    update = "2h"
    delete = "2h"
  }

  type                = "ExpressRoute"
  sku                 = var.sku

  enable_bgp          = true

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.exrgw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  tags = var.tags
}
