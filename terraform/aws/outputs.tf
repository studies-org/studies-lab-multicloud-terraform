output "site_url" {
  description = "Endereço do site pelo load balancer"
  value       = "http://${module.lb.dns_name}"
}

output "instances" {
  description = "Instâncias web: nome => IP privado"
  value       = zipmap(module.compute.instance_names, module.compute.private_ips)
}
