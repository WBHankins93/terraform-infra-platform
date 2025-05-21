variable "name" {
  type        = string
  description = "Name prefix for IAM resources"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN for EKS cluster"
}

variable "oidc_provider_url" {
  type        = string
  description = "OIDC issuer URL without https:// prefix"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for the service account"
}

variable "service_account" {
  type        = string
  description = "Kubernetes service account name used by controller"
}
