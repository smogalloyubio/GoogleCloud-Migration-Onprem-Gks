output "kubernetes_cluster_name" {
  value       = module.compute.kubernetes_cluster_name
  description = "GKE cluster name"
}

output "kubernetes_cluster_host" {
  value       = module.compute.kubernetes_cluster_host
  sensitive   = true
  description = "GKE cluster endpoint"
}

output "region" {
  value       = var.region
  description = "GCP region"
}

output "vpc_network_name" {
  value       = module.network.vpc_network_name
  description = "VPC network name"
}

output "subnet_name" {
  value       = module.network.subnet_name
  description = "Subnet name"
}

output "storage_bucket_name" {
  value       = module.storage.bucket_name
  description = "Cloud Storage bucket name"
}

output "storage_bucket_url" {
  value       = module.storage.bucket_url
  description = "Cloud Storage bucket URL"
}

output "artifact_registry_repository_name" {
  value       = module.artifactregistry.repository_name
  description = "Artifact Registry repository name"
}

output "artifact_registry_url" {
  value       = "${module.artifactregistry.repository_location}-docker.pkg.dev/${var.project_id}/${module.artifactregistry.repository_name}"
  description = "Artifact Registry URL for Docker images"
}

output "github_actions_service_account_email" {
  value       = module.serviceaccount.github_actions_service_account_email
  description = "GitHub Actions service account email"
}

output "gke_workload_service_account_email" {
  value       = module.serviceaccount.gke_workload_service_account_email
  description = "GKE workload service account email"
}

output "project_id" {
  value       = var.project_id
  description = "GCP project ID"
}
