locals {
  vpc_id                  = module.network.vpc_id
  stage                   = var.stack_id
  sg_rds_prod             = module.network.sg_rds_prod
  sg_alb                  = module.network.sg_alb
  sg_ec2                  = module.network.sg_ec2
  certificate_arn         = var.certificate_arn
  certificate_arn_frontend = var.certificate_arn_frontend
  subnet_wordpress_a      = module.network.subnets_public[0]
  subnet_wordpress_b      = module.network.subnets_public[1]
  subnet_databases_prod_a = module.network.subnets_private[0]
  subnet_databases_prod_b = module.network.subnets_private[1]
  zone_local_id           = module.network.zone_id == "NONE" || module.network.zone_id == null ? null : module.network.zone_id
}