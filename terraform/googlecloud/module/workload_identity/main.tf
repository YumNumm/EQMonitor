data "google_project" "project" {
  project_id = var.project_id
}

resource "google_iam_workload_identity_pool" "github_actions_app_pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
  display_name              = var.identity_pool_display_name
  description               = var.identity_pool_description
}

resource "google_iam_workload_identity_pool_provider" "github_actions_techoapp_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_app_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.identity_pool_provider_display_name
  description                        = var.identity_pool_provider_description

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }

  attribute_condition = "assertion.repository == '${var.identity_assertion_repository}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_binding" "github_actions_techoapp_binding" {
  service_account_id = var.service_account_name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_actions_app_pool.workload_identity_pool_id}/attribute.repository/${var.identity_assertion_repository}"
  ]
}
