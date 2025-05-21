# Terraform VPC Module

This module provisions a complete AWS Virtual Private Cloud (VPC) including public/private subnets, internet and NAT gateways, route tables, and subnet associations. It’s designed for reusability, teaching, and real-world dev/stage/prod environments.

---

## 🔧 What It Creates

- AWS VPC
- Public subnets across 2 AZs
- Private subnets across 2 AZs
- Internet Gateway (IGW)
- NAT Gateway with Elastic IP
- Route tables and associations

---

## 🗂 File Breakdown

| File               | Purpose                                                  |
|--------------------|----------------------------------------------------------|
| `main.tf`          | Base VPC resource                                        |
| `variables.tf`     | Declares all module inputs                               |
| `outputs.tf`       | Exposes VPC, subnet, and gateway IDs                     |
| `subnets.tf`       | Creates public/private subnets in multiple AZs           |
| `nat.tf`           | Deploys IGW, NAT GW, and EIP                              |
| `route_tables.tf`  | Handles routing logic and subnet associations            |

---

## ✅ Inputs

These should be passed in via `.tfvars` or directly from the overlay (like `overlays/dev`).

```hcl
variable "name" {
  type        = string
  description = "Name tag prefix for all resources"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the overall VPC"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for private subnets"
}
```

📤 Outputs
```hcl
output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
```

🧪 Example Usage (from overlays/dev/main.tf)
```hcl
module "vpc" {
  source                = "../../modules/vpc"
  name                  = var.name
  cidr_block            = var.cidr_block
  azs                   = var.azs
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}
```

🚀 How to Test It
```hcl
cd overlays/dev
terraform init -backend=false
terraform plan -var-file="terraform.tfvars"
```

✅ Use -backend=false during local development to avoid AWS credential issues.

🛠 Next Steps & Extensions
Add VPC Flow Logs

Create IAM roles for EKS cluster

Provision Kubernetes (EKS) on top

Attach security groups for apps/load balancers

📚 Why This Repo is Great for SREs
Clean module and overlay separation

GitHub Actions CI built-in for PR validation

Clear separation of infrastructure layers

Human-readable output for onboarding and learning

Real-world deployable code for dev environments




Maintainer
Built by Ben Hankins