## AWS Work Account Login via 1Password
This project uses 1Password CLI to securely retrieve AWS credentials for use with Terraform and the AWS CLI.

## Step-by-Step AWS Login

```bash
# 1. Authenticate with 1Password CLI
eval $(op signin)

# 2. Export AWS credentials from shared vault
export AWS_ACCESS_KEY_ID=$(op read "op://SRE Shared/proveai-terraform-state-bucket/access_key")
export AWS_SECRET_ACCESS_KEY=$(op read "op://SRE Shared/proveai-terraform-state-bucket/secret_key")
export AWS_DEFAULT_REGION=us-east-1

```

## ✅ Validate Your Session

Run this to confirm you're logged in:

```bash
aws sts get-caller-identity
```