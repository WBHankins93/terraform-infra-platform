variable "name" {
  type        = string
  description = "Prefix for cluster and role names"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster (usually private)"
}

variable "node_instance_type" {
  type        = string
  description = "Instance type for worker nodes"
  default     = "t3.medium"
}
