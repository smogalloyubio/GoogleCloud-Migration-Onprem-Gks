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

variable "region" {
  type        = string
  description = "GCP region"
}
