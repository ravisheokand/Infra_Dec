variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the virtual machine will be created."
  type        = string

}

variable "vm_location" {
  description = "The location where the virtual machine will be created."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the virtual machine."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the virtual machine."
  type        = string
  sensitive   = true
}

variable "image_publisher" {
  description = "The publisher of the image to use for the virtual machine."
  type        = string
}

variable "image_offer" {
  description = "The offer of the image to use for the virtual machine."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image to use for the virtual machine."
  type        = string
}

variable "image_version" {
  description = "The version of the image to use for the virtual machine."
  type        = string
}

variable "nic_id" {
  description = "The ID of the network interface to associate with the virtual machine."
  type        = string
}


variable "key_vault_name" {
  description = "Name of the Key Vault to retrieve secrets from"
  type        = string
}
