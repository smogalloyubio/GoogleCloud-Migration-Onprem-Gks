variable "region" {
  type        = string
  description = "GCP region"
}

variable "repository_name" {
  type        = string
  description = "Name of the Artifact Registry repository"
  default     = "ecommerce-docker"
}

variable "keep_count" {
  type        = number
  description = "Number of recent versions to keep"
  default     = 10
}

variable "github_actions_service_account" {
  type        = string
  description = "GitHub Actions service account (format: serviceAccount:email@project.iam.gserviceaccount.com)"
}

variable "gke_service_account" {
  type        = string
  description = "GKE service account (format: serviceAccount:email@project.iam.gserviceaccount.com)"
}
