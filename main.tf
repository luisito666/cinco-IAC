# Network 
module "network" {
  source                  = "./modules/network"
  vpc_cidr                = var.vpc_cidr
  stack_id                = var.stack_id
  layer                   = var.layer
  region                  = var.region
  subnets_private         = var.subnets_private
  subnets_public          = var.subnets_public
  transit_gateway         = var.transit_gateway
  create_acm_certificate  = false
  create_aws_route53_zone = false
  domain                  = var.domain
}

# RDS Database
module "database" {
  source                  = "./modules/database"
  project                 = "${var.layer}-${var.stack_id}"
  subnet-production-dcp   = local.subnet_databases_prod_a
  subnet-production-dca   = local.subnet_databases_prod_b
  vpc_security_group_ids  = [local.sg_rds_prod]
  name                    = "${var.layer}-${var.stack_id}"
  how_many_rds_instances  = 1
  instance_class          = "db.r4.large"
  db_username             = var.db_username
  db_password             = var.db_password
  db_name                 = var.db_name
  db_port                 = var.db_port
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_parameter_group_name = var.db_parameter_group_name
  depends_on = [
    module.network
  ]
}

# EC2 - Bastion
module "ec2" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id
  project                = "${var.layer}-${var.stack_id}"
  instance_type          = var.instance_type
  subnet_id              = local.subnet_wordpress_a
  vpc_security_group_ids = [local.sg_ec2]
  volume_size            = var.volume_size
  domain_app             = "${var.layer}-${var.stack_id}"
  region                 = var.region
  key_name               = var.key_name
}


#Backend - Microservicios 
module "backend" {
  source                      = "./modules/backend"
  stage                       = var.stack_id
  project                     = var.layer
  region                      = var.region
  account                     = var.account
  ecr_name                    = "${var.layer}-${var.stack_id}-${var.ecr_name}"
  certificate_arn             = local.certificate_arn
  security_groups             = local.sg_alb
  security_group_microservice = [local.sg_alb]
  db_host                     = module.database.db_endpoint
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_name                     = var.db_name
  site_url                    = var.WORDPRESS_SITE_URL
  subnets = [
    local.subnet_wordpress_a,
    local.subnet_wordpress_b
  ]
  vpc_id         = local.vpc_id
  container_port = var.container_port
  microservice   = var.microservice_name
  domain_app     = var.domain_app
  cpu            = var.cpu
  memory         = var.memory
  depends_on = [
    module.network, module.database
  ]
}

# Frontend
module "frontend" {
  source          = "./modules/frontend"
  project         = var.layer
  region          = var.region
  bucket-name     = var.bucket-name
  certificate_arn_frontend = local.certificate_arn_frontend
  dns_alb         = module.backend.dns_alb
  stage           = var.stack_id
  depends_on = [
    module.network, module.backend
  ]
}
