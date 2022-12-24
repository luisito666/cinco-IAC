# Contains the code that provisions the resources in the cloud.

# Load Balancer AWS

resource "aws_lb" "iac" {
  name               = "alb-${var.stage}-${var.project}"
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    "Name" = "alb-${var.stage}-${var.group}-${var.project}"
  }
}

# Target Group 
resource "aws_lb_target_group" "iac" {
  name                 = "${replace(var.microservice, "_", "-")}-${var.stage}-${var.group}"
  target_type          = "ip"
  port                 = var.container_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  health_check {
    healthy_threshold   = "10"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = "404"
    timeout             = "10"
    path                = "/404"
    unhealthy_threshold = "3"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Listener HTTP
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.iac.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
# Listener HTTPS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.iac.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac.arn
  }
}