variable "sqlserver_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string

}

variable "location" {
  description = "The Azure region where the SQL Server will be created."
  type        = string

}

variable "sql_administrator_login" {
  description = "The administrator login for the SQL Server."
  type        = string
  sensitive   = true
}

variable "sql_administrator_password" {
  description = "The password for the SQL Server administrator."
  type        = string
  sensitive   = true
}