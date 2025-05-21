variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_certificate" {
  type = string
}

variable "kube_token" {
  type        = string
  description = "Temporary token from EKS auth (generated via AWS CLI)"
}

variable "aws_region" {
  type = string
}

variable "depends_on_cluster" {
  description = "Reference to EKS cluster resource"
}
