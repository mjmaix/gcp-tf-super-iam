output "tf_super_sa_name" {
  value       = google_service_account.tf_super_sa.name
  description = "The fully qualified name of the super service account."
}

output "tf_super_sa_id" {
  value       = google_service_account.tf_super_sa.id
  description = "The identifier for the super service account with format projects/{{project}}/serviceAccounts/{{email}}"
}

output "tf_super_sa_unique_id" {
  value       = google_service_account.tf_super_sa.name
  description = "The unique id of the super service account."
}
