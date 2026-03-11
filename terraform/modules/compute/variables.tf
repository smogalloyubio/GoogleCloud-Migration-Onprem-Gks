variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "ecommerce-gke-cluster"
}

variable "zone" {
  type        = string
  description = "GCP zone for GKE cluster"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "network_id" {
  type        = string
  description = "ID of the VPC network"
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
