terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.46"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "random_string" "random" {
  length           = 5
  special          = false
  lower            = true
  upper            = false
}
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccount${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


output "storage_account" {
  value = azurerm_storage_account.example.name
 }
