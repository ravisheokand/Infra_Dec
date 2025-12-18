terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
#      version = "~>4.43.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "DoNotDeleteRg"
    storage_account_name = "donotdeletestorage5"
    container_name       = "tfstate"
    key                  = "rks_dec.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ff1980ab-1170-4014-971d-df65aabf1e5b"
}  