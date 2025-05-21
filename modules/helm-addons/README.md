## 🔐 Helm Authentication (Temporary: kube_token)

To allow Terraform to install Helm charts on your EKS cluster, you must provide a valid Kubernetes token.

Set it in your terminal before running Terraform:

```bash
export TF_VAR_kube_token=$(aws eks get-token --cluster-name dev-eks --region us-east-1 | jq -r .status.token)
```

Note: This is a temporary solution. Once IRSA is configured, this will no longer be required.

Unset it when done:

```
unset TF_VAR_kube_token
```