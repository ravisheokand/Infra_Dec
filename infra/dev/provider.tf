terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.56.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "DoNotDeleteRg"
    storage_account_name = "donotdeletestorage55555"
    container_name       = "tfstate"
    key                  = "rks_122025.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "c2030b51-2f02-4c24-9532-07a55f218345"
}