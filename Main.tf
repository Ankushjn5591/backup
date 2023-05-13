provider "azurerm" {
  features {}
}

# Define a resource group for the Recovery Services Vault and VM
data "azurerm_resource_group" "rg1" {
  name     = "ankushrg"
}


# Define the Recovery Services Vault
resource "azurerm_recovery_services_vault" "vault" {
  name                = "myvault01"
  location            = data.azurerm_resource_group.rg1.location
  resource_group_name = data.azurerm_resource_group.rg1.name
  sku                 = "Standard"
}


terraform {
  backend "azurerm" {
    resource_group_name  = "Storagerg"
    storage_account_name = "storageaccount5591"
    container_name       = "tfstate"
    key                  = "backup.terraform.tfstate"
    access_key = "9DcT8nW/iKr0v2t8bfFIfM24sfJRGva1oD4macMbw6UkSwUXYHJr0ErQzgv15oErzQebT6lpi4zl+ASt2Lfeeg=="
  }
}







