resource "google_storage_bucket" "app_storage" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30
    }
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 90
    }
  }
}

resource "google_storage_bucket_iam_member" "artifact_registry_access" {
  bucket = google_storage_bucket.app_storage.name
  role   = "roles/storage.admin"
  member = var.service_account_email
}
