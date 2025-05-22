variable "name" {
  description = "Environment name (used for naming resources)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
}

variable "kube_token" {
  description = "Authentication token for Kubernetes cluster"
  type        = string
}

variable "alb_namespace" {
  type        = string
  description = "Namespace for ALB-related resources"
}

variable "irsa_namespace" {
  type        = string
  description = "Namespace for IRSA resources"
}
