terraform {
  required_version = "1.13.5"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "7.11.0"
    }
  }
}
