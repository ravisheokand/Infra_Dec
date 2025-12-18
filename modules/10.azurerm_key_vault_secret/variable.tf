variable "secret_name" {
  description = "The name of the Key Vault secret."
  type        = string
}

variable "secret_value" {
  description = "The value of the Key Vault secret."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault where the secret will be stored."
  type        = string

}

variable "rg_name" {
  description = "The name of the resource group where the Key Vault is located."
  type        = string
}