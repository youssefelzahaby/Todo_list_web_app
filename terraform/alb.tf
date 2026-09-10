resource "aws_lb_target_group" "TG" {
  name     = "todo-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.to_do_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "todo-app-tg"
  }
}




resource "aws_lb" "ALB" {
  name               = "todo-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.ALB-SG.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = {
    Name = "todo-alb"
  }
}



resource "aws_lb_listener" "ALB-listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}

