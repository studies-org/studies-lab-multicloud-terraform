variable "project" {
  description = "Nome base dos recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "public_subnets" {
  description = "Subnets públicas: AZ => CIDR"
  type        = map(string)
}
