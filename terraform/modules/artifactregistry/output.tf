output "repository_name" {
  value       = google_artifact_registry_repository.docker_repo.name
  description = "Name of the Artifact Registry repository"
}

output "repository_location" {
  value       = google_artifact_registry_repository.docker_repo.location
  description = "Location of the Artifact Registry repository"
}

output "repository_id" {
  value       = google_artifact_registry_repository.docker_repo.repository_id
  description = "ID of the Artifact Registry repository"
}

output "repository_url" {
  value       = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev"
  description = "Artifact Registry repository URL"
}
