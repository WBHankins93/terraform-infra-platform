name                 = "dev-vpc"
cidr_block           = "10.0.0.0/16"
azs                  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

node_instance_type   = "t3.medium"
aws_region           = "us-east-1"

alb_namespace        = "kube-system"
alb_service_account  = "aws-load-balancer-controller"

irsa_namespace    = "default"
