output "vm_ids" {
  description = "IDs das VMs web"
  value       = azurerm_linux_virtual_machine.web[*].id
}

output "vm_names" {
  description = "Nomes das VMs web"
  value       = local.vm_names
}

output "nic_ids" {
  description = "IDs das NICs das VMs (entram no backend pool do LB)"
  value       = azurerm_network_interface.web[*].id
}

output "ip_configuration_name" {
  description = "Nome da ip_configuration das NICs"
  value       = local.ip_configuration_name
}

output "private_ips" {
  description = "IPs privados das VMs web"
  value       = azurerm_network_interface.web[*].private_ip_address
}
