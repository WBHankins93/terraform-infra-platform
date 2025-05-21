variable "cidr_block" {
  type        = string
  description = "The CIDR block to assign to the VPC"
}

variable "name" {
  type        = string
  description = "A name to tag the VPC with"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for private subnets"
}
