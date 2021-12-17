resource "google_service_account" "tf_super_sa" {
  account_id   = var.super_sa_account_id
  display_name = var.super_sa_name
  project      = var.gcp_project
}

resource "google_service_account_iam_binding" "tf_super_sa_role_binding" {
  service_account_id = google_service_account.tf_super_sa.name
  role               = "roles/editor" # fixme: VERY POWERFUL, must reduce
  members            = []
}
