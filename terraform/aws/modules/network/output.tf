output "vpc_id_output" {
  value = aws_vpc.vpc.id  
}

output "subnet1a_id_output" {
  value = aws_subnet.subnet1a.id
}

output "subnet1c_id_output" {
  value = aws_subnet.subnet1c.id
}