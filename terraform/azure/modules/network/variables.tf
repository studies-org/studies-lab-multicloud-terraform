variable "project" {
  description = "Nome base dos recursos"
  type        = string
}

variable "location" {
  description = "Região do Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group dos recursos"
  type        = string
}

variable "vnet_cidr" {
  description = "Espaço de endereços da VNet"
  type        = string
}

variable "subnets" {
  description = "Subnets: nome => CIDR"
  type        = map(string)
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs liberados para SSH (vazio = SSH fechado)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
