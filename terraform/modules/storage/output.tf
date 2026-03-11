output "bucket_name" {
  value       = google_storage_bucket.app_storage.name
  description = "Name of the Cloud Storage bucket"
}

output "bucket_self_link" {
  value       = google_storage_bucket.app_storage.self_link
  description = "Self link of the Cloud Storage bucket"
}

output "bucket_url" {
  value       = "gs://${google_storage_bucket.app_storage.name}"
  description = "URL of the Cloud Storage bucket"
}
