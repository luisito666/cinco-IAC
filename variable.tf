/* ENVIRONMENT  */
variable "stack_id" {
  description = "Nombre del ambiente"
  type        = string
}

variable "layer" {
  description = "Nombre del proyecto"
  type        = string
}

variable "type" {
  description = "Tipo del recurso, infra, frontend, movil, backend"
  type        = string
  default     = null
}

variable "component_name" {
  description = "Nombre del componente"
  type        = string
  default     = null
}

variable "region" {
  default = "us-east-1"
}

/* NETWORK MODULE  */

variable "vpc_cidr" {
  description = "CIDR Block to VPC"
  type        = string
}
variable "subnets_private" {
  description = "List subnet private"
  type        = list(any)
}
variable "subnets_public" {
  description = "List subnet public"
  type        = list(any)
}

variable "transit_gateway" {
  description = "Identifier transit gateway"
  type        = string
}

# General Variables
variable "account" {
  description = "ID Root AWS Account"
}
variable "profile" {
  description = "Profile to account AWS"
  default     = "default"
}

variable "domain" {
  description = "Domain Project"
  default     = null
}
variable "stage" {
  description = "Stage Project"
  default     = "prod"
}
variable "group" {
  description = "Front or Back Microservices"
  default     = "backend"
}
variable "country" {
  description = "Country to deploy"
  default     = "co"
}


# Database
variable "db_name" {
  description = "Name of Database"
}
variable "db_port" {
  description = "Port Mysql"
  default     = 3306
}
variable "db_username" {
  description = "Admin user to Dababase"
}
variable "db_password" {
  description = "Password to Database"
}
variable "cluster_name" {
  description = "Name of Mysql Cluster"
}
variable "db_engine" {
  default = "aurora-mysql"
}
variable "db_engine_version" {
  default = "5.7.mysql_aurora.2.10.2"
}
variable "db_parameter_group_name" {
  default = "default.aurora-mysql5.7"
}

# EC2

variable "ami_id" {
  description = "Ami to deploy"
}
variable "instance_type" {
  description = "Type of instance"
}
variable "volume_size" {
  description = "Volume Size EC2"
  default     = 8
}

# Backend Microservices
variable "microservices_backend" {
  type = set(string)
  default = [
    "wordpress"
  ]
}
variable "container_port" {
  description = "Microservice Port"
  default     = "80"
}
variable "microservice_name" {
  description = "Microservice Name"
}
variable "domain_app" {
  description = "Domain to app"
}
variable "cpu" {
  description = "CPU"
  default     = 512
}
variable "memory" {
  description = "Memory"
  default     = 1024
}
variable "ecr_name" {
  description = "ECR Name"
}

# Frontend

variable "bucket-name" {
  description = "Bucket Name to Static Content"
}
variable "WORDPRESS_SITE_URL" {
  description = "to setup env variables"
}

variable "certificate_arn" {
}
variable "key_name" {
  
}

variable certificate_arn_frontend {
  
}