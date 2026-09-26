variable "project" {
  description = "Nome base dos recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets onde as instâncias são distribuídas (round-robin)"
  type        = list(string)
}

variable "instance_count" {
  description = "Quantidade de instâncias"
  type        = number
}

variable "instance_type" {
  description = "Tipo das instâncias"
  type        = string
}

variable "key_name" {
  description = "Key pair para SSH (opcional)"
  type        = string
  default     = null
}

variable "lb_sg_id" {
  description = "Security group do load balancer, única origem liberada na porta 80"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs liberados para SSH (vazio = SSH fechado)"
  type        = list(string)
  default     = []
}
