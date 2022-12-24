resource "aws_route_table" "public_routing_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name   = "${var.layer}_${var.stack_id}_route_table_public"
    Source = "Terraform"
  }
}

#routing tables private
resource "aws_route_table" "private_routing_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway
  }
  tags = {
    Name   = "${var.layer}_${var.stack_id}_route_table_private"
    Source = "Terraform"
  }
}
# Subnets Association

# aws_route_table_association public subnets
resource "aws_route_table_association" "public_subnets_routing_table_associations" {
  count          = length(var.subnets_public)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_routing_table.id
}

# aws_route_table_association private subnets
resource "aws_route_table_association" "private_subnets_routing_table_associations" {
  count          = length(var.subnets_private)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_routing_table.id
}
