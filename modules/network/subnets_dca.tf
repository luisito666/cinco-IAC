resource "aws_subnet" "public_subnets" {
  count                   = length(var.subnets_public)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets_public[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name   = "${var.layer}_${var.stack_id}_subnet_public_${count.index + 1}"
    Source = "Terraform"
  }
}

#private_subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.subnets_private)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnets_private[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name   = "${var.layer}_${var.stack_id}_subnet_private_${count.index + 1}"
    Source = "Terraform"
  }
}