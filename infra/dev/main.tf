module "resource_group" {
  source      = "../../modules/1.azurerm_resource_group"
  rg_name     = "RKS_Infra_RG_dev"
  rg_location = "New Zealand North"
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../../modules/2.azurerm_virtual_network"
  vnet_name     = "RK-vnet"
  rg_location   = module.resource_group.rg_location
  rg_name       = module.resource_group.rg_name
  address_space = ["10.1.0.0/16"]
}

module "frontend_subnet" {
  depends_on           = [module.virtual_network]
  source               = "../../modules/3.azurerm_subnet"
  subnet_name          = "FE-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  rg_name              = module.resource_group.rg_name
  address_prefixes     = ["10.1.0.0/28"]
}

module "backend_subnet" {
  depends_on           = [module.virtual_network]
  source               = "../../modules/3.azurerm_subnet"
  subnet_name          = "BE-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  rg_name              = module.resource_group.rg_name
  address_prefixes     = ["10.1.0.16/28"]
}

module "pip_forntend" {
  depends_on        = [module.resource_group]
  source            = "../../modules/4.azurerm_public_ip"
  pip_name          = "RK-frontend-pip"
  rg_name           = module.resource_group.rg_name
  location          = module.resource_group.rg_location
  allocation_method = "Static"
}

module "pip_backend" {
  depends_on        = [module.resource_group]
  source            = "../../modules/4.azurerm_public_ip"
  pip_name          = "RK-backend-pip"
  rg_name           = module.resource_group.rg_name
  location          = module.resource_group.rg_location
  allocation_method = "Static"
}

module "network_security_group_frontend" {
  depends_on = [module.frontend_subnet]
  source     = "../../modules/5.azurerm_network_security_group"
  nsg_name   = "RK-nsg-frontend"
  rg_name    = module.resource_group.rg_name
  location   = module.resource_group.rg_location
  subnet_id  = module.frontend_subnet.subnet_id
}

module "network_security_group_backend" {
  depends_on = [module.backend_subnet]
  source     = "../../modules/5.azurerm_network_security_group"
  nsg_name   = "RK-nsg-backend"
  rg_name    = module.resource_group.rg_name
  location   = module.resource_group.rg_location
  subnet_id  = module.backend_subnet.subnet_id
}

module "nic_frontend" {
  depends_on   = [module.frontend_subnet]
  source       = "../../modules/6.azurerm_network_interface"
  nic_name     = "RK-frontend-nic"
  rg_name      = module.resource_group.rg_name
  nic_location = module.resource_group.rg_location
  pip_id       = module.pip_forntend.pip_id
  subnet_id    = module.frontend_subnet.subnet_id
}

module "nic_backend" {
  depends_on   = [module.backend_subnet]
  source       = "../../modules/6.azurerm_network_interface"
  nic_name     = "RK-backend-nic"
  rg_name      = module.resource_group.rg_name
  nic_location = module.resource_group.rg_location
  pip_id       = module.pip_backend.pip_id
  subnet_id    = module.backend_subnet.subnet_id
}

module "sqlserver" {
  depends_on                 = [module.resource_group]
  source                     = "../../modules/7.azurerm_sql_server"
  rg_name                    = module.resource_group.rg_name
  location                   = module.resource_group.rg_location
  sqlserver_name             = "rk-sqlserver"
  sql_administrator_login    = "rkadmin"
  sql_administrator_password = "Ericsson@123"
}

module "sql_database" {
  depends_on        = [module.sqlserver]
  source            = "../../modules/8.azurerm_sql_database"
  rg_name           = module.resource_group.rg_name
  sql_server_name   = module.sqlserver.sql_server_name
  sql_database_name = "rk-sqldb"
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../modules/9.azurerm_key_vault"
  kv_name    = "rk-kv-sep"
  rg_name    = module.resource_group.rg_name
  location   = module.resource_group.rg_location
}

module "vm_username" {
  depends_on     = [module.key_vault]
  source         = "../../modules/10.azurerm_key_vault_secret"
  key_vault_name = module.key_vault.key_vault_name
  rg_name        = module.resource_group.rg_name
  secret_name    = "vm-username"
  secret_value   = "rkadmin"
}

module "vm_password" {
  depends_on     = [module.key_vault]
  source         = "../../modules/10.azurerm_key_vault_secret"
  key_vault_name = module.key_vault.key_vault_name
  rg_name        = module.resource_group.rg_name
  secret_name    = "vm-password"
  secret_value   = "Ericsson@123"
}

module "frontend_vm" {
  depends_on      = [module.nic_frontend, module.vm_username, module.vm_password]
  source          = "../../modules/11.azurerm_virtual_machine"
  vm_name         = "RK-forntend-vm"
  rg_name         = module.resource_group.rg_name
  vm_location     = module.resource_group.rg_location
  nic_id          = module.nic_frontend.nic_id
  vm_size         = "Standard_D2s_v3"
  image_publisher = "canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"
  image_version   = "latest"
  key_vault_name  = "rk-kv-sep"
  admin_username  = module.vm_username.secret_value
  admin_password  = module.vm_password.secret_value
}

module "backend_vm" {
  depends_on      = [module.nic_frontend, module.vm_username, module.vm_password]
  source          = "../../modules/11.azurerm_virtual_machine"
  vm_name         = "RK-backend-vm"
  rg_name         = module.resource_group.rg_name
  vm_location     = module.resource_group.rg_location
  nic_id          = module.nic_backend.nic_id
  vm_size         = "Standard_D2s_v3"
  image_publisher = "canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts-gen2"
  image_version   = "latest"
  key_vault_name  = "rk-kv-sep"
  admin_username  = module.vm_username.secret_value
  admin_password  = module.vm_password.secret_value
}