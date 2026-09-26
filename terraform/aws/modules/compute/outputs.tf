output "instance_ids" {
  description = "IDs das instâncias web"
  value       = aws_instance.web[*].id
}

output "instance_names" {
  description = "Nomes das instâncias web"
  value       = [for i in range(var.instance_count) : format("web-%02d", i + 1)]
}

output "private_ips" {
  description = "IPs privados das instâncias web"
  value       = aws_instance.web[*].private_ip
}

output "security_group_id" {
  description = "Security group das instâncias web"
  value       = aws_security_group.web.id
}
