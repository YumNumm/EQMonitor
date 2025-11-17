locals {
  project_id = "eqmonitor-main"
}

module "iam" {
  source     = "../../module/iam"
  prefix     = "production"
  project_id = local.project_id
}

module "workload_identity" {
  source                              = "../../module/workload_identity"
  pool_id                             = "github-actions-pool"
  project_id                          = local.project_id
  identity_pool_display_name          = "GitHub Actions Pool"
  identity_pool_description           = "Workload identity pool for GitHub Actions"
  identity_pool_provider_display_name = "GitHub Actions Pool Provider"
  identity_pool_provider_description  = "Workload identity pool provider for GitHub Actions"
  identity_assertion_repository       = "YumNumm/EQMonitor"
  service_account_name                = module.iam.github_actions_eqmonitor_service_account_name
  provider_id                         = "github-actions--provider"
}
