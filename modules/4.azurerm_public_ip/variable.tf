variable "pip_name" {
  type        = string
  description = "The name of the public IP address."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group where the public IP address will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the public IP address will be created."
}

variable "allocation_method" {
  type        = string
  description = "The allocation method for the public IP address. Can be 'Static' or 'Dynamic'."
  default     = "Static"
}