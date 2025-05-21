module "vpc" {
  source     = "../../modules/vpc"
  name       = "dev-vpc"
  cidr_block = "10.0.0.0/16"
}
