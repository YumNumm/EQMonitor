variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "pool_id" {
  type        = string
  description = "Pool ID"
}

variable "provider_id" {
  type        = string
  description = "Provider ID"
}

variable "identity_pool_display_name" {
  type        = string
  description = "Pool display name"
}

variable "identity_pool_description" {
  type        = string
  description = "Pool description"
}

variable "identity_pool_provider_display_name" {
  type        = string
  description = "Provider display name"
}

variable "identity_pool_provider_description" {
  type        = string
  description = "Provider description"
}

variable "identity_assertion_repository" {
  type        = string
  description = "Assertion repository"
}

variable "service_account_name" {
  type        = string
  description = "Service account name"
}
