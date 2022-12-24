
locals {
  create_https  = var.certificate_arn != null ? 1 : 0
}