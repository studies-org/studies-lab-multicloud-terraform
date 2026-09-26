output "fqdn" {
  description = "FQDN público do load balancer"
  value       = azurerm_public_ip.lb.fqdn
}

output "public_ip" {
  description = "IP público do load balancer"
  value       = azurerm_public_ip.lb.ip_address
}

output "backend_pool_id" {
  description = "ID do backend pool"
  value       = azurerm_lb_backend_address_pool.web.id
}
