variable "admin_password" {
  description = "Senha do usuário administrador das VMs (defina via TF_VAR_admin_password)"
  type        = string
  sensitive   = true
}
