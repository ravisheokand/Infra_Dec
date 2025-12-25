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
    storage_account_name = "donotdeletestorage555555"
    container_name       = "tfstate"
    key                  = "rks_122025.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a9076473-03ad-4c76-8993-4edd69689ba6"
}