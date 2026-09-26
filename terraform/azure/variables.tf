variable "project" {
  description = "Nome base dos recursos"
  type        = string
  default     = "staticsite-multicloud"
}

variable "location" {
  description = "Região do Azure"
  type        = string
  default     = "brazilsouth"
}

variable "vnet_cidr" {
  description = "Espaço de endereços da VNet"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnets" {
  description = "Subnets: nome => CIDR"
  type        = map(string)
  default = {
    "snet-web-a" = "10.1.5.0/24"
    "snet-web-b" = "10.1.6.0/24"
  }
}

variable "vm_count" {
  description = "Quantidade de VMs atrás do load balancer"
  type        = number
  default     = 4
}

variable "vm_size" {
  description = "Tamanho das VMs"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuário administrador das VMs"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "Chave pública SSH do administrador (login por senha fica desativado)"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs liberados para SSH nas VMs (vazio = SSH fechado)"
  type        = list(string)
  default     = []
}

variable "dns_label" {
  description = "Rótulo DNS do IP público do LB (<label>.<região>.cloudapp.azure.com); precisa ser único na região"
  type        = string
}
