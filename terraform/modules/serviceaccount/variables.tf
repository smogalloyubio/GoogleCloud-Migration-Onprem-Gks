variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "github_actions_sa_name" {
  type        = string
  description = "Name of the GitHub Actions service account"
  default     = "github-actions-sa"
}

variable "gke_sa_name" {
  type        = string
  description = "Name of the GKE workload service account"
  default     = "gke-workload-sa"
}

variable "gke_namespace" {
  type        = string
  description = "Kubernetes namespace for GKE workload identity"
  default     = "default"
}

variable "gke_k8s_service_account" {
  type        = string
  description = "Kubernetes service account name for GKE workload identity"
  default     = "ecommerce-app"
}

variable "create_service_account_key" {
  type        = bool
  description = "Create a service account key for GitHub Actions (set to false if using Workload Identity Federation)"
  default     = false
}
