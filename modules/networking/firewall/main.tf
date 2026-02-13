resource "azurerm_firewall" "this" {
  count = var.enabled ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  tags                = var.tags

  ip_configuration {
    name                 = "${var.name}-ipconfig"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall[0].id
  }

  depends_on = [azurerm_public_ip.firewall]
}

resource "azurerm_public_ip" "firewall" {
  count = var.enabled ? 1 : 0

  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
