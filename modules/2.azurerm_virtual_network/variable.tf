variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "rg_location" {
  type        = string
  description = "Location for the Virtual Network"
}

variable "rg_name" {
  type        = string
  description = "Name of the Resource Group where the Virtual Network will be created"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the Virtual Network"
}