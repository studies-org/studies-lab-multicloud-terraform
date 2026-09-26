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

variable "subnet_ids" {
  description = "Subnets onde as VMs são distribuídas (round-robin)"
  type        = list(string)
}

variable "vm_count" {
  description = "Quantidade de VMs"
  type        = number
}

variable "vm_size" {
  description = "Tamanho das VMs"
  type        = string
}

variable "admin_username" {
  description = "Usuário administrador"
  type        = string
}

variable "admin_ssh_public_key" {
  description = "Chave pública SSH do administrador"
  type        = string
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
