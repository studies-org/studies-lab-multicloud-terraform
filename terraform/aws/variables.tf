variable "project" {
  description = "Nome base dos recursos"
  type        = string
  default     = "staticsite-multicloud"
}

variable "region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Subnets públicas: AZ => CIDR (o ALB exige pelo menos duas AZs)"
  type        = map(string)
  default = {
    "us-east-1a" = "10.0.5.0/24"
    "us-east-1c" = "10.0.6.0/24"
  }
}

variable "instance_count" {
  description = "Quantidade de instâncias web atrás do load balancer"
  type        = number
  default     = 4
}

variable "instance_type" {
  description = "Tipo das instâncias EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair para SSH (opcional)"
  type        = string
  default     = null
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs liberados para SSH nas instâncias (vazio = SSH fechado)"
  type        = list(string)
  default     = []
}
