terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.5.0"
    }
  }

  # Backend remoto com configuração parcial: veja backend.hcl.example
  backend "azurerm" {}
}

# Credenciais e assinatura vêm das variáveis ARM_CLIENT_ID, ARM_CLIENT_SECRET,
# ARM_TENANT_ID e ARM_SUBSCRIPTION_ID (ou do az login).
provider "azurerm" {
  resource_provider_registrations = "none"

  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
