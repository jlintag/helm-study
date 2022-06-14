# Configure the Azure provider
terraform {
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

 # You cannot create a new backend by simply defining this and then
 # immediately proceeding to "terraform apply". The S3 backend must
 # be bootstrapped according to the simple yet essential procedure in
 # https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "state_backend" {
  source                             = "./modules/backend"
  env_name                           = local.env_name
  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "${local.env_name}.backend.tf"
}
