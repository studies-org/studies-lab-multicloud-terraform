resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project}"
  location = var.location

  tags = local.tags
}

locals {
  tags = {
    project   = var.project
    managedBy = "terraform"
  }
}

module "network" {
  source = "./modules/network"

  project             = var.project
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  vnet_cidr           = var.vnet_cidr
  subnets             = var.subnets
  ssh_allowed_cidrs   = var.ssh_allowed_cidrs
  tags                = local.tags
}

module "compute" {
  source = "./modules/compute"

  project              = var.project
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  subnet_ids           = module.network.subnet_ids
  vm_count             = var.vm_count
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key
  tags                 = local.tags
}

module "lb" {
  source = "./modules/lb"

  project             = var.project
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_label           = var.dns_label
  backend_count       = var.vm_count
  backend_nic_ids     = module.compute.nic_ids
  backend_ip_config   = module.compute.ip_configuration_name
  tags                = local.tags
}
