# Terraform EKS Platform – Production-Ready AWS Infrastructure

This repository demonstrates a full production-grade Kubernetes platform on AWS, built with Terraform and GitHub Actions. It's modular, secure, CI-integrated, and designed to be reusable for real-world engineering teams.

> ✅ Built as a portfolio showcase with real infrastructure patterns  
> ✅ Secure, scalable, and Git-managed  
> ✅ All resources are deployed and destroyed in a cost-safe window  

---

## Features

- **Modular Terraform** — VPC, EKS, IAM, IRSA, Helm addons
- **CI/CD with GitHub Actions** — Auto `plan`, manual `apply` approval
- **ALB Ingress Controller** — Public app routing via AWS ALB
- **SecretsManager Access via IRSA** — No static creds, pod-based IAM
- **Helm Addons** — Cluster Autoscaler, ALB Controller
- **Clean Environment Overlay** — `overlays/dev` supports env branching
- **Full Docs** — Teardown, IRSA, Ingress, and Architecture

---

## Architecture

```text
GitHub Actions (CI/CD)
    └── Terraform Plan + Apply
        └── Modular Infra Code
            ├── VPC
            ├── EKS Cluster + OIDC
            ├── IRSA Roles
            ├── Helm-based Addons
            └── ALB Ingress
```

## Security Highlights

- ✅ **Uses IRSA with OIDC** — no hardcoded AWS keys
- ✅ **Least-privilege IAM per pod**
- ✅ **All secrets live in AWS SecretsManager**
- ✅ **Terraform-managed trust boundaries** (IAM roles + annotations)


## Public Access via ALB
```yaml
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip
```

- Application is exposed via an ALB
- ELB DNS is used (Route53 optional)
- Supports both HTTP and TLS via ACM


## Folder Structure
```text
.
├── modules/
│   ├── eks/
│   ├── vpc/
│   ├── helm-addons/
│   ├── secrets-irsa/
│   └── iam-load-balancer/
├── overlays/
│   └── dev/
├── .github/
│   └── workflows/
├── docs/
│   ├── architecture.md
│   ├── teardown.md
│   ├── secrets-irsa.md
│   └── ingress.md
└── README.md
```

## 🛠️ Usage (Local)

```bash
cd overlays/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

Add -backend=false during local development if avoiding S3 or OIDC setup

## CI/CD Workflows
 - terraform-dev.yaml: runs terraform plan on pull requests

 - terraform-apply-dev.yaml: gated terraform apply on manual trigger

 - Secrets like TF_VAR_kube_token are stored in:
    - GitHub → Settings → Secrets and Variables → Actions


## Cleanup
Once you're finished, destroy all resources with:

```bash
terraform destroy -var-file="terraform.tfvars"
```

See docs/teardown.md for full cleanup process and best practices.

