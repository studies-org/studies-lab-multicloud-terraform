locals {
  frontend_name = "public"
}

resource "azurerm_public_ip" "lb" {
  name                = "pip-lb-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.dns_label
  tags                = var.tags
}

resource "azurerm_lb" "this" {
  name                = "lb-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = local.frontend_name
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "web" {
  name            = "pool-web"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "http" {
  name                = "probe-http"
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 15
}

resource "azurerm_lb_rule" "http" {
  name                           = "http"
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = local.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web.id]
  probe_id                       = azurerm_lb_probe.http.id
  disable_outbound_snat          = true
}

# As VMs não têm IP público: a saída para a internet (apt, por exemplo)
# passa pelo IP do LB através desta regra de outbound.
resource "azurerm_lb_outbound_rule" "internet" {
  name                    = "outbound-internet"
  loadbalancer_id         = azurerm_lb.this.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id

  frontend_ip_configuration {
    name = local.frontend_name
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "web" {
  count = var.backend_count

  network_interface_id    = var.backend_nic_ids[count.index]
  ip_configuration_name   = var.backend_ip_config
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id
}
