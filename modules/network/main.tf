data "aws_availability_zones" "available" {}
#vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name   = "vpc_${var.layer}_${var.stack_id}"
    Source = "Terraform"
  }
}

resource "aws_vpc_dhcp_options" "iac" {
  domain_name = "iac.local"
  domain_name_servers = [
    "169.254.169.253",
    "10.66.38.2",
    "1.1.1.1",
    "8.8.8.8",
  ]
  ntp_servers = [
    "45.11.105.223",
    "194.0.5.123",
    "200.89.75.198",
    "45.11.105.243"
  ]

  tags = {
    Name = "DHCP Options iac"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.iac.id
}

#internet_gateway
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name   = "${var.layer}_${var.stack_id}_IG"
    Source = "Terraform"
  }
}

#transit_gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "transit_gateway_attachment" {
  subnet_ids         = aws_subnet.private_subnets[*].id
  transit_gateway_id = var.transit_gateway
  vpc_id             = aws_vpc.vpc.id

  tags = {
    Name   = "${var.layer}_${var.stack_id}_transit_gateway_attachment"
    Source = "Terraform"
  }
}
