output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "IDs das subnets públicas, na ordem das AZs"
  value       = [for az in sort(keys(aws_subnet.public)) : aws_subnet.public[az].id]
}
