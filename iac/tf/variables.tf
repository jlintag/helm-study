variable "env_name" {
  description = "Environment"
  type        = string
}

variable "azure_app_id" {
  description = "Azure App Id for Service Principal"
  type        = string
  sensitive = true
}
variable "azure_password" {
  description = "Azure Password for service principal"
  type        = string
  sensitive = true
}
variable "azure_tenant_id" {
  description = "Azure tenant for service principal"
  type        = string
  sensitive = true
}
variable "azure_subscription_id" {
  description = "Azure subscription-id for service principal"
  type        = string
  sensitive = true
}
variable "tags" {
 type = object({
   ManagedBy = string
   Environment  = string
 })
 default = {
    ManagedBy   = "Terraform"
    Environment = "dev"
 }
}