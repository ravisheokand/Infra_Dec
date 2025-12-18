resource "azurerm_mysql_flexible_database" "sql_database" {
  name                = var.sql_database_name
  resource_group_name = var.rg_name
  server_name         = var.sql_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}