variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone for GKE cluster"
  default     = "us-central1-a"
}

# Network variables
variable "network_name" {
  type        = string
  description = "Name of the VPC network"
  default     = "ecommerce-vpc"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "ecommerce-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the subnet"
  default     = "10.0.0.0/20"
}

# Compute (GKE) variables
variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "ecommerce-gke-cluster"
}

variable "initial_node_count" {
  type        = number
  description = "Initial number of nodes in the cluster"
  default     = 1
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the node pool"
  default     = 2
}

variable "machine_type" {
  type        = string
  description = "Machine type for nodes"
  default     = "e2-medium"
}

variable "preemptible" {
  type        = bool
  description = "Use preemptible nodes to save costs"
  default     = true
}

# Storage variables
variable "bucket_name" {
  type        = string
  description = "Name of the Cloud Storage bucket (must be globally unique)"
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning for the bucket"
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket to be destroyed even if it contains objects"
  default     = false
}

# Artifact Registry variables
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

# Service Account variables
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
  description = "Create a service account key for GitHub Actions"
  default     = false
}
