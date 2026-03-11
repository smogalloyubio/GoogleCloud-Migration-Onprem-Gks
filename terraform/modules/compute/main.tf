resource "google_container_cluster" "primary" {
  name     = var.cluster_name
   zone   =  var.zone
  network    = var.network_name
  subnetwork = var.subnet_name

  # Cluster settings
  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  depends_on = [
    var.network_id
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  zone  = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count


  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    tags = ["gke-node"]
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
