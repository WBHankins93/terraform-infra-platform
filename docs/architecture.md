# 🧱 Platform Architecture: EKS + IRSA + Terraform + GitHub Actions

This document provides a full architecture breakdown of a cloud-native, production-ready Kubernetes platform built on AWS. It is designed to showcase best practices in infrastructure automation, security (IRSA), scalability, and developer experience.

---

## 🌐 High-Level Overview

The platform consists of:

- **AWS VPC**: Custom network topology with public/private subnets
- **Amazon EKS**: Managed Kubernetes control plane with self-managed node group
- **IRSA (IAM Roles for Service Accounts)**: Pod-level identity for least-privilege AWS access
- **GitHub Actions**: Automated `plan` + `apply` workflows gated by manual approval
- **AWS Load Balancer Controller**: Helm-deployed ALB ingress provisioning
- **SecretsManager + Kubernetes**: Secure secret access using IRSA and pod annotations
- **Terraform (modular)**: Clean separation of core infra and app-level configuration

---

## 📐 Architectural Layout

```text
                      ┌────────────────────────────┐
                      │     GitHub Actions CI/CD   │
                      │  (plan + apply workflows)  │
                      └────────────┬───────────────┘
                                   │
                    ┌──────────────▼──────────────┐
                    │       Terraform Modules     │
                    │  VPC / EKS / IRSA / Addons  │
                    └──────────────┬──────────────┘
                                   │
                          ┌────────▼────────┐
                          │    AWS Account  │
                          └────────┬────────┘
                                   │
        ┌──────────────────────────┼────────────────────────────┐
        │                          │                            │
┌───────▼────────┐     ┌───────────▼──────────┐     ┌───────────▼─────────┐
│   VPC (3 AZs)  │     │     Amazon EKS       │     │  SecretsManager     │
│ - Pub/Priv sub │     │ - Cluster + nodes    │     │ - Encrypted secrets │
└────────────────┘     │ - OIDC configured    │     │ - IAM scoped access │
                       └──────────┬───────────┘     └─────────────────────┘
                                  │
                       ┌──────────▼──────────┐
                       │ Kubernetes Addons   │
                       │ - ALB Controller    │
                       │ - Cluster Autoscaler│
                       └──────────┬──────────┘
                                  │
                       ┌──────────▼───────────┐
                       │   Application Pods   │
                       │ - IRSA-based SA      │
                       │ - Env/config injected│
                       └──────────┬───────────┘
                                  │
                       ┌──────────▼──────────────┐
                       │ AWS ALB (Ingress)       │
                       │ - HTTP public access    │
                       │ - DNS via ELB hostname  │
                       └─────────────────────────┘
```

## 🔧 Core Terraform Modules

| Module             | Purpose                                               |
|--------------------|--------------------------------------------------------|
| `vpc/`             | Defines reusable VPC with public/private AZs          |
| `eks/`             | Provisions EKS + OIDC provider, exposes outputs       |
| `iam-load-balancer/` | IAM role for ALB controller (IRSA)                  |
| `secrets-irsa/`    | IAM role + ServiceAccount for secret-reading pods     |
| `helm-addons/`     | Deploys autoscaler, ALB controller with SA bindings   |
| `route53-zone/`    | (Optional) Creates hosted zone for public DNS         |

---

## 🔐 Security & Identity (IRSA)

This platform strictly avoids in-cluster AWS credentials by using:

- **OIDC**: EKS cluster identity provider (federated)
- **IRSA**: IAM roles scoped to individual Kubernetes ServiceAccounts
- **IAM Policies**: Least-privilege, resource-specific access

> This ensures each pod only has access to what it needs — nothing more.

---

## 🚀 CI/CD Workflow

- **Terraform Plan**: Triggered on PR or push via GitHub Actions
- **Terraform Apply**: Triggered manually with input confirmation
- **Secrets**: `TF_VAR_kube_token` provided securely via GitHub Actions secrets

---

## 🧪 Testing Strategy

All resources are applied once at the end of the build:

- Single `terraform apply` via GitHub Actions
- Public access validated via ALB
- Secret fetch via pod logged to stdout
- Screenshots captured post-deploy
- Resources are destroyed immediately after to avoid AWS cost

---

## ✅ Platform Goals

| Goal                             | Achieved |
|----------------------------------|----------|
| Reusable, modular Terraform      | ✅       |
| CI/CD-controlled provisioning    | ✅       |
| Secure IRSA for IAM integration  | ✅       |
| Helm-driven cluster addons       | ✅       |
| Public access via ALB Ingress    | ✅       |
| Cost-safe teardown workflow      | ✅       |
