terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Credentials come from ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID and
  # ARM_CLIENT_SECRET environment variables. Load them with: . .\.env.ps1
}
