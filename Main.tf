provider "azurerm" {
  features {}
}

# Define a resource group for the Recovery Services Vault and VM
data "azurerm_resource_group" "rg1" {
  name     = "ankushrg"
}

data "azurerm_virtual_machine" "vm" {
  name     = "vm1"
  resource_group_name = "ankushrg"
}

# Define the Recovery Services Vault
resource "azurerm_recovery_services_vault" "vault" {
  name                = "myvault01"
  location            = data.azurerm_resource_group.rg1.location
  resource_group_name = data.azurerm_resource_group.rg1.name
  sku                 = "Standard"
}



# Define a backup policy for the virtual machine
resource "azurerm_recovery_services_protection_policy" "policy" {
  name                = "vm1policy"
  resource_group_name = data.azurerm_resource_group.rg1.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  backup_policy {
    frequency = "daily"
    time      = "18:25"
    retention_daily {
      count = 5
    }
    retention_weekly {
      count = 4
    }
  }
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







