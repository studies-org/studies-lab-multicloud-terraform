resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "web" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

resource "azurerm_network_security_group" "web" {
  name                = "nsg-web-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  dynamic "security_rule" {
    for_each = length(var.ssh_allowed_cidrs) > 0 ? [1] : []
    content {
      name                       = "SSH"
      priority                   = 1011
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefixes    = var.ssh_allowed_cidrs
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "web" {
  for_each = azurerm_subnet.web

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.web.id
}
