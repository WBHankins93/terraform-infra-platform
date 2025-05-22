# 🔐 Secure Secret Access with IRSA + AWS SecretsManager

This guide explains how Kubernetes pods running on EKS retrieve secrets from AWS Secrets Manager using IAM Roles for Service Accounts (IRSA).

---

## ✅ Why IRSA?

Traditional secret injection methods (e.g., mounting secrets, static environment vars, or external sync tools) come with drawbacks:

- 🔓 Risk of leaked credentials in container logs or env dumps
- ⚠️ Overprivileged IAM roles shared across pods
- ❌ Static credentials that violate least privilege

**IRSA solves this by assigning IAM roles directly to Kubernetes ServiceAccounts**, giving pods only the AWS permissions they need — nothing more.

---

## How It Works

1. The EKS cluster is configured with an **OIDC identity provider**
2. An IAM role is created that trusts the EKS OIDC provider for a specific ServiceAccount
3. That IAM role is given **SecretsManager access** to specific secrets only
4. A Kubernetes pod uses the ServiceAccount
5. AWS automatically injects temporary credentials for that IAM role into the pod

---

## Module: `modules/secrets-irsa/`

This reusable module includes:

- `aws_iam_role`: Trusted via OIDC
- `aws_iam_policy`: Scopes permissions to `secretsmanager:GetSecretValue`
- `kubernetes_service_account`: Automatically annotated with the IAM role ARN

Inputs:

| Variable         | Description                                    |
|------------------|------------------------------------------------|
| `name`           | Prefix for naming IAM role and policy          |
| `namespace`      | Kubernetes namespace for the ServiceAccount    |
| `service_account`| The name of the Kubernetes ServiceAccount      |
| `secret_arns`    | List of AWS SecretsManager ARNs allowed        |
| `oidc_provider_arn` | OIDC ARN from EKS                           |
| `oidc_provider_url` | URL for EKS OIDC                            |

---

## Terraform Usage Example

```hcl
module "secrets_irsa" {
  source              = "../../modules/secrets-irsa"
  name                = "app"
  namespace           = "default"
  service_account     = "app-secret-reader"
  secret_arns         = [aws_secretsmanager_secret.app.arn]
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.oidc_provider_url
}
```

## Testing Access (Post-Deploy)

A test pod (`secret-checker`) is deployed with this IRSA-enabled ServiceAccount. It:

- Uses the AWS CLI to call `secretsmanager:GetSecretValue`
- Logs the result to stdout for visibility
- Proves IRSA + least-privilege secret access is functioning correctly

---

## ✅ Security Highlights

- **No static credentials**
- **Least privilege enforced per pod**
- **Temporary AWS credentials auto-rotated by IRSA**
- **Auditable IAM policy usage with Terraform**

This is a production-grade pattern for secure, scalable AWS secret access on Kubernetes.
