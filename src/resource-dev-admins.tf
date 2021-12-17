module "service_account-iam-bindings" {
  source = "github.com/terraform-google-modules/terraform-google-iam//modules/service_accounts_iam?ref=v7.4.0"

  service_accounts = []
  project          = var.gcp_project
  mode             = "additive"
  bindings = {
    "roles/editor" = var.admin_members
  }
}
