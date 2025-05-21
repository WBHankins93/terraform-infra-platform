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

variable "vpc_id" {
  type        = string
  description = "VPC ID used by the ALB controller"
}

variable "alb_service_account" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "ServiceAccount name used by ALB controller"
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "Namespace for Helm charts and service accounts"
}

variable "alb_iam_role_arn" {
  type        = string
  description = "IAM Role ARN for ALB Controller (IRSA)"
}
