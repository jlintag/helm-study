locals {

  terraform_backend_config_file = format(
    "%s/%s",
    var.terraform_backend_config_file_path,
    var.terraform_backend_config_file_name
  )
  
  terraform_backend_config_template_file = var.terraform_backend_config_template_file != "" ? var.terraform_backend_config_template_file : "${path.module}/templates/terraform.tf.tpl"
  
  terraform_backend_config_content = templatefile(local.terraform_backend_config_template_file, {
    resource_group_name  = azurerm_resource_group.helm_study_state_rg.name
    storage_account_name = azurerm_storage_account.helm_study_sa.name
    container_name       = azurerm_storage_container.tfstate.name
    terraform_state_file = var.terraform_state_file
    terraform_version    = var.terraform_version
  })
}

resource "azurerm_resource_group" "helm_study_state_rg" {
  name     = "helm_study_state_rg"
  location = "eastus"
  tags = {
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_account" "helm_study_sa" {
  name                     = "helmstudysa"
  resource_group_name      = azurerm_resource_group.helm_study_state_rg.name
  location                 = azurerm_resource_group.helm_study_state_rg.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "${var.env_name}-tfstate"
  storage_account_name  = azurerm_storage_account.helm_study_sa.name
  container_access_type = "blob"
}

resource "azurerm_management_lock" "backend_lock" {
  name       = "backend_lock"
  scope      = azurerm_storage_account.helm_study_sa.id
  lock_level = "CanNotDelete"
  notes      = "Let's not delete the backend for tfstate"
} 

resource "local_file" "terraform_backend_config" {
  count           = var.terraform_backend_config_file_path != "" ? 1 : 0
  content         = local.terraform_backend_config_content
  filename        = local.terraform_backend_config_file
  file_permission = "0644"
}
