locals {
  ip_configuration_name = "internal"
  vm_names              = [for i in range(var.vm_count) : format("vm-%02d", i + 1)]
}

resource "azurerm_availability_set" "web" {
  name                = "avail-web-${var.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  managed             = true
  tags                = var.tags
}

resource "azurerm_network_interface" "web" {
  count = var.vm_count

  name                = "nic-${local.vm_names[count.index]}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = local.ip_configuration_name
    subnet_id                     = var.subnet_ids[count.index % length(var.subnet_ids)]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web" {
  count = var.vm_count

  name                  = local.vm_names[count.index]
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  availability_set_id   = azurerm_availability_set.web.id
  network_interface_ids = [azurerm_network_interface.web[count.index].id]
  tags                  = var.tags

  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    name                 = "osdisk-${local.vm_names[count.index]}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init.sh.tftpl", {
    instance_name = local.vm_names[count.index]
  }))
}
