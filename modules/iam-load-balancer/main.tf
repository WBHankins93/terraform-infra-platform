resource "aws_iam_policy" "alb_controller" {
  name        = "${var.name}-alb-controller-policy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = file("${path.module}/iam-policy-load-balancer-controller.json")
}

resource "aws_iam_role" "alb_controller" {
  name = "${var.name}-alb-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = var.oidc_provider_arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${var.oidc_provider_url}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account}"
        }
      }
    }]
  })

  tags = {
    Name = "${var.name}-alb-controller-role"
  }
}

resource "aws_iam_role_policy_attachment" "attach_alb_policy" {
  policy_arn = aws_iam_policy.alb_controller.arn
  role       = aws_iam_role.alb_controller.name
}
