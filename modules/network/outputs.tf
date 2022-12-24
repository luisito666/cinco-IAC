output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}
output "sg_rds_prod" {
  description = "ID Security Group RDS"
  value       = aws_security_group.sg_rds_prod.id
}
output "sg_alb" {
  description = "ID Security Group ALB"
  value       = aws_security_group.sg_alb.id
}
output "sg_ec2" {
  description = "ID Security Group EC2"
  value       = aws_security_group.sg_ec2.id
}
output "certificate_arn" {
  value = try(aws_acm_certificate.iac[0].arn, "NONE")
}
output "subnets_public" {
  value = aws_subnet.public_subnets[*].id
}
output "subnets_private" {
  value = aws_subnet.private_subnets[*].id
}
output "zone_id" {
  value = try(aws_route53_zone.iac[0].id,"NONE")
}