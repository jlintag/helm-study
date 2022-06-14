
variable "terraform_version" {
  type        = string
  default     = "1.1.0"
  description = "The minimum required terraform version"
}
variable "env_name" {
  description = "Environment"
  type        = string
}
variable "terraform_backend_config_file_path" {
  description = "Backend file path"
  type        = string
}
variable "terraform_backend_config_file_name" {
  description = "Backend file name"
  type        = string
}
variable "terraform_backend_config_template_file" {
  type        = string
  default     = ""
  description = "Template for backend configuration"
}
variable "terraform_state_file" {
  type        = string
  default     = "terraform.tfstate"
  description = "The path to the state file inside the bucket"
}