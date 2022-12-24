# Security Groups Rules

#  Databases - Production 

resource "aws_security_group" "sg_rds_prod" {
  name        = "${var.layer}_${var.stack_id}_database"
  description = "SG Databases"
  vpc_id      = aws_vpc.vpc.id

  dynamic "egress" {
    for_each = var.egress_rules_sg_rds_prod
    content {
      cidr_blocks = egress.value.cidr_blocks
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
    }
  }
  dynamic "ingress" {
    for_each = var.ingress_rules_sg_rds_prod
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }
  tags = {
    Name : "${var.layer}_${var.stack_id}_database"
  }
}

# ALB

resource "aws_security_group" "sg_alb" {
  name        = "${var.layer}_${var.stack_id}_ALB"
  description = "${var.layer}_${var.stack_id}_ALB"
  vpc_id      = aws_vpc.vpc.id

  dynamic "egress" {
    for_each = var.egress_rules_sg_alb
    content {
      cidr_blocks = egress.value.cidr_blocks
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
    }
  }
  dynamic "ingress" {
    for_each = var.ingress_rules_sg_alb
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }
  tags = {
    Name : "${var.layer}_${var.stack_id}_ALB"
  }
}

# EC2

resource "aws_security_group" "sg_ec2" {
  name        = "SG EC2 Bastion"
  description = "SG EC2 Bastion"
  vpc_id      = aws_vpc.vpc.id

  dynamic "egress" {
    for_each = var.egress_rules_sg_ec2
    content {
      cidr_blocks = egress.value.cidr_blocks
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
    }
  }
  dynamic "ingress" {
    for_each = var.ingress_rules_sg_ec2
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
    }
  }
  tags = {
    Name : "SG EC2 Bastion"
  }
}