terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}

resource "azurerm_mysql_flexible_server" "sqlserver" {
  name                   = var.sqlserver_name
  resource_group_name    = var.rg_name
  location               = var.location
  version                = "8.0.21"
  sku_name               = "GP_Standard_D2ds_v4"
  administrator_login    = var.sql_administrator_login
  administrator_password = var.sql_administrator_password
}