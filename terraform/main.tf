module "network" {
  source = "./modules/network"

  network_name = var.network_name
  subnet_name  = var.subnet_name
  subnet_cidr  = var.subnet_cidr
  region       = var.region
}

module "compute" {
  source = "./modules/compute"

  cluster_name       = var.cluster_name
  zone               = var.zone
  project_id         = var.project_id
  network_name       = module.network.vpc_network_name
  subnet_name        = module.network.subnet_name
  network_id         = module.network.vpc_network_id
  initial_node_count = var.initial_node_count
  node_count         = var.node_count
  machine_type       = var.machine_type
  preemptible        = var.preemptible

  depends_on = [module.network]
}

module "storage" {
  source = "./modules/storage"

  bucket_name              = var.bucket_name
  region                   = var.region
  versioning_enabled       = var.versioning_enabled
  force_destroy            = var.force_destroy
  service_account_email    = module.serviceaccount.github_actions_service_account_email

  depends_on = [module.serviceaccount]
}

module "artifactregistry" {
  source = "./modules/artifactregistry"

  region                            = var.region
  repository_name                   = var.repository_name
  keep_count                        = var.keep_count
  github_actions_service_account    = "serviceAccount:${module.serviceaccount.github_actions_service_account_email}"
  gke_service_account               = "serviceAccount:${module.serviceaccount.gke_workload_service_account_email}"

  depends_on = [module.serviceaccount]
}

module "serviceaccount" {
  source = "./modules/serviceaccount"

  project_id                    = var.project_id
  github_actions_sa_name        = var.github_actions_sa_name
  gke_sa_name                   = var.gke_sa_name
  gke_namespace                 = var.gke_namespace
  gke_k8s_service_account       = var.gke_k8s_service_account
  create_service_account_key    = var.create_service_account_key
}
