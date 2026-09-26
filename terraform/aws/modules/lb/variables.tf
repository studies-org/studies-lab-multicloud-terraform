variable "project" {
  description = "Nome base dos recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets públicas do ALB (duas AZs ou mais)"
  type        = list(string)
}

variable "target_count" {
  description = "Quantidade de instâncias registradas no target group"
  type        = number
}

variable "target_ids" {
  description = "IDs das instâncias registradas no target group"
  type        = list(string)
}
