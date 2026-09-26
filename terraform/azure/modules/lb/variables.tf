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

variable "dns_label" {
  description = "Rótulo DNS do IP público"
  type        = string
}

variable "backend_count" {
  description = "Quantidade de NICs no backend pool"
  type        = number
}

variable "backend_nic_ids" {
  description = "IDs das NICs que entram no backend pool"
  type        = list(string)
}

variable "backend_ip_config" {
  description = "Nome da ip_configuration das NICs"
  type        = string
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
