/* ENVIRONMENT  */

stack_id = "prod"
layer    = "cinco"
region   = "us-east-1"
account  = "306809727018" #SANDBOX  account TO TEST
domain   = "cincobmm.com"
certificate_arn = "arn:aws:acm:us-east-1:306809727018:certificate/b7b693d3-9bf7-4f7d-bd0e-e9def6453876"

/* NETWORK  */
vpc_cidr        = "10.66.38.0/25"
subnets_private = ["10.66.38.0/27", "10.66.38.32/27", "10.66.38.64/28"]
subnets_public  = ["10.66.38.80/28", "10.66.38.96/28", "10.66.38.112/28"]
transit_gateway = "tgw-09d00f3f21f93a3b9"

/* DATABASE  */

db_username  = "unoraya_elberth"
db_password  = "Comandos1992#"
db_name      = "unoraya_fds"
db_port      = 3306
cluster_name = "cluster-aurora-mysql"

/* EC2  */
ami_id        = "ami-0cff7528ff583bf9a"
instance_type = "t2.nano"
volume_size   = 8

/* Backend Microservice */
container_port     = "80"
microservice_name  = "wordpress"
domain_app         = "cincobmm.com"
cpu                = 512
memory             = 1024
ecr_name           = "cinco"
WORDPRESS_SITE_URL = "cincobmm.com"

/* Frontend  */
bucket-name        = "assets.cincobmm.com"
key_name           = "prod-cinco-bastion"
certificate_arn_frontend = "arn:aws:acm:us-east-1:306809727018:certificate/fc2c688d-0a89-405e-b6a1-3714ecbbece4"