# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"      
      #version = "~> 3.50.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.3.0"
    }
  }
  # required_version = ">= 1.3.4"

  backend "azurerm" {
  }
}

provider "azurerm" {
  disable_terraform_partner_id = !(var.enableTelemetry)
  partner_id                   = "9b4433d6-924a-4c07-b47c-7478619759c7"
  features {
   # resource_group {
   #   prevent_deletion_if_contains_resources = false
   # }
  }
}
