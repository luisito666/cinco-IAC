resource "aws_route53_zone" "iac" {
  count = var.create_aws_route53_zone ? 1 : 0
  name = var.domain
  vpc {
    vpc_id     = aws_vpc.vpc.id
    vpc_region = var.region
  }
  tags = {
    "Name" = "${var.domain}"
  }
}
