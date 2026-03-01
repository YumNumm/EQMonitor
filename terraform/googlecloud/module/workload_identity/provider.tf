terraform {
  required_version = "1.14.6"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = "7.11.0"
    }
  }
}
