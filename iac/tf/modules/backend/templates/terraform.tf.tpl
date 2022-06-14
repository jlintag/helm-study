terraform {
  required_version = ">= ${terraform_version}"

  backend "azurerm" {
    resource_group_name  = "${resource_group_name}"
    storage_account_name = "${storage_account_name}"
    container_name       = "${container_name}"
    key                  = "${terraform_state_file}"
  }
}
