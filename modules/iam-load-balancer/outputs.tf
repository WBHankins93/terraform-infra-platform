output "iam_role_arn" {
  value       = aws_iam_role.alb_controller.arn
  description = "IAM role ARN for ALB controller IRSA"
}
