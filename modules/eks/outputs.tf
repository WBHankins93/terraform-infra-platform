output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS cluster API server endpoint"
}

output "cluster_certificate" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  description = "EKS cluster certificate"
}
