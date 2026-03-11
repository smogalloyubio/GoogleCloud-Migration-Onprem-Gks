variable "bucket_name" {
  type        = string
  description = "Name of the Cloud Storage bucket"
}

variable "region" {
  type        = string
  description = "GCP region"
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

variable "service_account_email" {
  type        = string
  description = "Service account email for bucket access"
}
