resource "google_service_account" "github_actions_eqmonitor_service_account" {
  account_id = "actions-eqmonitor-${var.prefix}"
  display_name = "GitHub Actions EQMonitor Service Account"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_eqmonitor_app_distro_admin_member" {
  project = var.project_id
  # See: https://firebase.google.com/docs/projects/iam/roles-predefined-product?hl=ja#app-distro
  role   = "roles/firebaseappdistro.admin"
  member = "serviceAccount:${google_service_account.github_actions_eqmonitor_service_account.email}"
}

output "github_actions_eqmonitor_service_account_name" {
  value = google_service_account.github_actions_eqmonitor_service_account.name
}
