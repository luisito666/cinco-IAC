resource "aws_acm_certificate" "iac" {
  count       = var.create_acm_certificate ? 1: 0
  domain_name = "*.${var.domain}"
  subject_alternative_names = [
    "*.${var.domain}",
  ]
  validation_method = "DNS"
  tags = {
    "Name" = "${var.domain}"
  }
}