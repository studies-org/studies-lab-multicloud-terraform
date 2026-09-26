output "vnet_id" {
  description = "ID da VNet"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "IDs das subnets, em ordem alfabética do nome"
  value       = [for name in sort(keys(azurerm_subnet.web)) : azurerm_subnet.web[name].id]
}

output "nsg_id" {
  description = "ID do NSG das subnets web"
  value       = azurerm_network_security_group.web.id
}
