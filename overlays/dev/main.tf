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
