# https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com?project=eqmonitor-main
resource "google_project_service" "iamcredentials_service" {
  project = var.project_id
  service = "iamcredentials.googleapis.com"
}

# https://console.cloud.google.com/apis/library/iam.googleapis.com?project=eqmonitor-main
resource "google_project_service" "iam_service" {
  project = var.project_id
  service = "iam.googleapis.com"
}

# https://console.cloud.google.com/apis/library/firebaseappdistribution.googleapis.com?project=eqmonitor-main
resource "google_project_service" "firebaseappdistribution_service" {
  project = var.project_id
  service = "firebaseappdistribution.googleapis.com"
}

resource "google_service_account" "github_actions_app_distro_service_account" {
  account_id   = "actions-eqmonitor-appdistro"
  display_name = "GitHub Actions EQMonitor Service Account"
  project      = var.project_id
  depends_on = [ google_project_service.iamcredentials_service, google_project_service.firebaseappdistribution_service ]
}

resource "google_project_iam_member" "github_actions_app_distro_admin_member" {
  project = var.project_id
  # See: https://firebase.google.com/docs/projects/iam/roles-predefined-product?hl=ja#app-distro
  role   = "roles/firebaseappdistro.admin"
  member = "serviceAccount:${google_service_account.github_actions_app_distro_service_account.email}"
}

output "github_actions_app_distro_service_account_name" {
  value = google_service_account.github_actions_app_distro_service_account.name
}


resource "google_service_account" "github_actions_writer_service_account" {
  account_id   = "actions-eqmonitor-writer"
  display_name = "GitHub Actions EQMonitor Service Account"
  project      = var.project_id
}
resource "google_project_iam_member" "github_actions_writer_member" {
  project = var.project_id
  role   = "roles/writer"
  member = "serviceAccount:${google_service_account.github_actions_writer_service_account.email}"
}

output "github_actions_writer_service_account_name" {
  value = google_service_account.github_actions_writer_service_account.name
}
