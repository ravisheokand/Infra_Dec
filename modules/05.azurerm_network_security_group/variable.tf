variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "location" {
  description = "Location for the Network Security Group"
  type        = string
}
variable "rg_name" {
  description = "Name of the Resource Group where the Network Security Group will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the Subnet to associate with the Network Security Group"
  type        = string
}