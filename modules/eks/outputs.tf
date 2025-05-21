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

output "node_group_name" {
  value       = aws_eks_node_group.default.node_group_name
  description = "Name of the EKS node group"
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.oidc.arn
  description = "OIDC provider ARN"
}

output "oidc_provider_url" {
  value       = replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")
  description = "OIDC provider URL (stripped)"
}
