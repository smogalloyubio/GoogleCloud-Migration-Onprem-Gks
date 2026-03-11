# GCP Project Configuration
project_id = "YOUR_GCP_PROJECT_ID"  
region     = "us-central1"          
zone       = "us-central1-a"       

# Network Configuration
network_name = "ecommerce-vpc"
subnet_name  = "ecommerce-subnet"
subnet_cidr  = "10.0.0.0/20"

# GKE Cluster Configuration
cluster_name       = "ecommerce-gke-cluster"
initial_node_count = 1
node_count         = 2
machine_type       = "e2-medium"    
preemptible        = true         


bucket_name        = "ecommerce-app-bucket-YOUR_PROJECT_ID"  
versioning_enabled = true
force_destroy      = false

# Artifact Registry Configuration
repository_name = "ecommerce-docker"
keep_count      = 10

# Service Account Configuration
github_actions_sa_name    = "github-actions-sa"
gke_sa_name               = "gke-workload-sa"
gke_namespace             = "default"
gke_k8s_service_account   = "ecommerce-app"
create_service_account_key = false  # Use Workload Identity Federation instead
