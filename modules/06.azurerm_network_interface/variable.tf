variable "nic_name" {
  description = "The name of the network interface."
  type        = string
}

variable "nic_location" {
  description = "The location of the network interface."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the network interface and virtual machine will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the network interface will be created."
  type        = string
}

variable "pip_id" {
  description = "The ID of the public IP address to associate with the network interface."
  type        = string

}