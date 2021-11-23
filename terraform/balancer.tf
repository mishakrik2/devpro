# Define Application Load Balancer.

resource "aws_alb" "ec2-alb" {
  name               = "ec2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sec_group.id]
  subnets            = [aws_subnet.main-subnet-public-1.id, aws_subnet.main-subnet-public-2.id]
}

# Define front target group.

resource "aws_alb_target_group" "front-web" {
  name                        = "front-web"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}

# Create HTTP Listener for load balancer.

resource "aws_alb_listener" "default" {
  load_balancer_arn = aws_alb.ec2-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.front-web.arn
  }
}


# Back instance target group
resource "aws_alb_target_group" "back-instance" {
  name                        = "back-instance"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}


# Listener for back instance

#resource "aws_alb_listener" "back" {
#  load_balancer_arn = aws_alb.ec2-alb.arn
#  port              = 80
#  protocol          = "HTTP"
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_alb_target_group.back-instance.arn
#  }
#}

# Attach target group to back instance

resource "aws_alb_target_group_attachment" "myadmin" {
  target_group_arn            = aws_alb_target_group.back-instance.arn
  target_id                   = aws_instance.back_instance.id
  port                        = 80
}

# Additional listener rule for /phpmyadmin path

resource "aws_alb_listener_rule" "myadmin-listener" {
  listener_arn                = aws_alb_listener.default.arn
  priority                    = 100

  action {
    type                      = "forward"
    target_group_arn          = aws_alb_target_group.back-instance.arn
  }
  condition {
    path_pattern {
      values                  = ["/phpmyadmin*"]
    }
  }
}