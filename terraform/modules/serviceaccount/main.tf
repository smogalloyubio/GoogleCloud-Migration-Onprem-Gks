resource "google_service_account" "github_actions" {
  account_id   = var.github_actions_sa_name
  display_name = "Service Account for GitHub Actions"
  description  = "Service account for GitHub Actions to push Docker images to Artifact Registry"
}

resource "google_service_account" "gke_workload" {
  account_id   = var.gke_sa_name
  display_name = "Service Account for GKE Workloads"
  description  = "Service account for GKE pods to pull images from Artifact Registry"
}

# GitHub Actions permissions
resource "google_project_iam_member" "github_actions_artifact_registry" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "github_actions_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

# GKE service account permissions
resource "google_project_iam_member" "gke_artifact_registry" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_workload.email}"
}

# Workload Identity binding for GKE
resource "google_service_account_iam_member" "gke_workload_identity" {
  service_account_id = google_service_account.gke_workload.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.gke_namespace}/${var.gke_k8s_service_account}]"
}

# Create service account key for GitHub Actions (optional)
resource "google_service_account_key" "github_actions_key" {
  count              = var.create_service_account_key ? 1 : 0
  service_account_id = google_service_account.github_actions.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
