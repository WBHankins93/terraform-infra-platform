module "vpc" {
  source     = "../../modules/vpc"
  name       = var.name
  cidr_block = var.cidr_block
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "eks" {
  source     = "../../modules/eks"
  name       = var.name
  subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = var.node_instance_type
}

module "helm_addons" {
  source              = "../../modules/helm-addons"
  cluster_name        = module.eks.cluster_name
  cluster_endpoint    = module.eks.cluster_endpoint
  cluster_certificate = module.eks.cluster_certificate
  kube_token          = var.kube_token
  aws_region          = var.aws_region
  vpc_id              = module.vpc.vpc_id
  alb_service_account = "aws-load-balancer-controller"
  depends_on_cluster  = module.eks
  namespace           = var.alb_namespace
  alb_iam_role_arn    = module.alb_iam_role.iam_role_arn
}

module "alb_iam_role" {
  source              = "../../modules/iam-load-balancer"
  name                = var.name
  namespace           = var.alb_namespace
  service_account     = "aws-load-balancer-controller"
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.oidc_provider_url
}

module "secrets_irsa" {
  source              = "../../modules/secrets-irsa"
  name                = var.name
  namespace           = var.irsa_namespace
  service_account     = "app-secret-reader"
  secret_arns         = [aws_secretsmanager_secret.app_secret.arn]
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.oidc_provider_url
}

resource "aws_secretsmanager_secret" "app_secret" {
  name = "devx-secret"
}