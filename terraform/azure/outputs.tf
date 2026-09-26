output "site_url" {
  description = "Endereço do site pelo load balancer"
  value       = "http://${module.lb.fqdn}"
}

output "vms" {
  description = "VMs web: nome => IP privado"
  value       = zipmap(module.compute.vm_names, module.compute.private_ips)
}
