module "vpc" {
  source     = "../../modules/vpc"
  name       = var.name
  cidr_block = var.cidr_block
}

module "eks" {
  source     = "../../modules/eks"
  name       = var.name
  subnet_ids = module.vpc.private_subnet_ids
}

module "eks" {
  source            = "../../modules/eks"
  name              = var.name
  subnet_ids        = module.vpc.private_subnet_ids
  node_instance_type = "t3.medium"
}

module "helm_addons" {
  source              = "../../modules/helm-addons"
  cluster_name        = module.eks.cluster_name
  cluster_endpoint    = module.eks.cluster_endpoint
  cluster_certificate = module.eks.cluster_certificate
  kube_token          = var.kube_token
  aws_region          = "us-east-1"
  depends_on_cluster  = module.eks
}

module "alb_iam_role" {
  source              = "../../modules/iam-load-balancer"
  name                = var.name
  namespace           = "kube-system"
  service_account     = "aws-load-balancer-controller"
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.oidc_provider_url
}
