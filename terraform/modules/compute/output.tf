output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Name of the GKE cluster"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
  description = "GKE cluster endpoint"
}

output "zone" {
  value       = var.zone
  description = "GCP zone where cluster is deployed"
}

output "project_id" {
  value       = var.project_id
  description = "GCP project ID"
}
