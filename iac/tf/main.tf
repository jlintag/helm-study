# Configure the Azure provider
terraform {
  backend "azurerm" {
    resource_group_name  = "helm_study_rg"
    storage_account_name = "helmstudysa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.22.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "helm_study_rg" {
  name     = "helm_study_rg"
  location = "eastus"
  tags = {
    ManagedBy   = "Terraform"
    Environment = var.env_name
  }
}

resource "azurerm_storage_account" "helm_study_sa" {
  name                     = "helmstudysa"
  resource_group_name      = azurerm_resource_group.helm_study_rg.name
  location                 = azurerm_resource_group.helm_study_rg.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.helm_study_sa.name
  container_access_type = "blob"
}