output "role_arn" {
  value       = aws_iam_role.irsa_role.arn
  description = "IAM role ARN used for IRSA"
}
