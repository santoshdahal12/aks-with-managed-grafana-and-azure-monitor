terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name  = "san-test-resources"
    storage_account_name = "<ur-storage-account-name>"
    container_name       = "tfstate"
    key                  = "basic-infra"
  }
}

provider "azurerm" {
   features {}
   skip_provider_registration = true
}