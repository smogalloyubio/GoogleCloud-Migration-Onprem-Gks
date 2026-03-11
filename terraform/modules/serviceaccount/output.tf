output "github_actions_service_account_email" {
  value       = google_service_account.github_actions.email
  description = "Email of the GitHub Actions service account"
}

output "github_actions_service_account_id" {
  value       = google_service_account.github_actions.unique_id
  description = "Unique ID of the GitHub Actions service account"
}

output "gke_workload_service_account_email" {
  value       = google_service_account.gke_workload.email
  description = "Email of the GKE workload service account"
}

output "gke_workload_service_account_id" {
  value       = google_service_account.gke_workload.unique_id
  description = "Unique ID of the GKE workload service account"
}

output "github_actions_key_id" {
  value       = var.create_service_account_key ? google_service_account_key.github_actions_key[0].name : null
  sensitive   = true
  description = "Key ID of the GitHub Actions service account key (if created)"
}
