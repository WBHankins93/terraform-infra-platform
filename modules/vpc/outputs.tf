output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
