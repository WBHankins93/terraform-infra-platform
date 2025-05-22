#  Teardown Guide

This guide ensures all cloud infrastructure and cost-bearing resources are safely removed at the end of the platform's lifecycle. It reflects best practices for cleanup in AWS, especially in temporary or demo environments.

---

## ⚠️ Before You Destroy

- ✅ Ensure all required screenshots and logs are captured
- ✅ Remove any critical outputs from dashboards or logs
- ✅ Inform other collaborators (if applicable)

---

##  Terraform Destroy (per environment)

```bash
cd overlays/dev
terraform destroy -var-file="terraform.tfvars"
```

##  What This Command Does

This command performs the following actions:

- Tears down the **EKS cluster**
- Deletes **VPC**, subnets, and route tables
- Removes **IRSA IAM roles** and attached IAM policies
- Uninstalls **Helm addons** (ALB Controller, Cluster Autoscaler)

---

##  Manual AWS Cleanup (if needed)

| Resource Type       | Action Required                                                    |
|---------------------|---------------------------------------------------------------------|
| **SecretsManager**  | Verify no secrets were created manually via AWS Console            |
| **ACM Certificates**| Only applicable if used — delete unused certs                      |
| **ALBs**            | Should be auto-removed by Terraform; confirm via AWS Console       |
| **Route53 Zones**   | Auto-deleted if created by Terraform; otherwise delete manually    |
| **S3 Buckets**      | ⚠️ Must be emptied **before** Terraform can delete the bucket      |

---

##  GitHub Actions Secrets Cleanup (Optional)

If you used sensitive tokens such as `KUBE_TOKEN`, you can clean them up in GitHub:

1. Go to:  
   `GitHub → Your Repo → Settings → Secrets and Variables → Actions`

2. Delete `KUBE_TOKEN` or any other secrets related to your environment.

---

## ✅ Post-Teardown Validation

To ensure all AWS resources have been removed, run the following commands:

```bash
aws eks list-clusters
aws ec2 describe-vpcs
aws iam list-roles | grep secrets-irsa
aws secretsmanager list-secrets
aws elbv2 describe-load-balancers
All of these should return empty, or only show unrelated resources from other environments.
```