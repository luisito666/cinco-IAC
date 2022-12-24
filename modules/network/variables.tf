variable "vpc_cidr" {
  description = "CIDR Global para la infraestructura"
}
variable "stack_id" {
  description = "Environment Name"
  type        = string
}
variable "layer" {
  description = "Name Project"
}
variable "domain" {
  description = "Domain Project"
  default     = null
}
variable "region" {
  description = "Region to deploy"
  default     = "us-east-1"
}
# Rules to Security Group

variable "egress_rules_sg_rds_prod" {
  description = "egress_rules_sg_rds_prod"
  default = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    }
  ]
}

variable "ingress_rules_sg_rds_prod" {
  description = "ingress_rules_sg_rds_prod"
  default = [
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = 3306
      to_port   = 3306
      protocol  = "tcp"
    }
  ]
}

# ALB

variable "egress_rules_sg_alb" {
  description = "egress_rules_sg_alb"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

  ]
}
variable "ingress_rules_sg_alb" {
  description = "ingress_rules_sg_alb"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 2999
      to_port     = 2999
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 111
      to_port     = 111
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 2999
      to_port     = 2999
      protocol    = "udp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 2049
      to_port     = 2049
      protocol    = "udp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 111
      to_port     = 111
      protocol    = "udp"
    }
  ]
}

# ec2

variable "egress_rules_sg_ec2" {
  description = "egress_rules_sg_ec2"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

  ]
}
variable "ingress_rules_sg_ec2" {
  description = "ingress_rules_sg_ec2"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    }
  ]
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

variable "create_acm_certificate" {
  type        = bool
  default     = false
  description = "To create acm certificate"
}
variable "create_aws_route53_zone" {
  type        =  bool
  default     = false
  description = "To create route53 zone"
}

