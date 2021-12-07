# Define Application Load Balancer - Blue

resource "aws_alb" "ec2-alb-blue" {
  name               = "ec2-alb-blue"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sec_group.id]
  subnets            = [aws_subnet.main-subnet-public-1.id, aws_subnet.main-subnet-public-2.id]
}

# Define Application Load Balancer - Green

resource "aws_alb" "ec2-alb-green" {
  name               = "ec2-alb-green"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sec_group.id]
  subnets            = [aws_subnet.main-subnet-public-1.id, aws_subnet.main-subnet-public-2.id]
}

# Define front target group for blue.

resource "aws_alb_target_group" "front-web-blue" {
  name                        = "front-web-blue"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}

# Define front target group for green.

resource "aws_alb_target_group" "front-web-green" {
  name                        = "front-web-green"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}


# Create HTTP Listener for load balancer blue.

resource "aws_alb_listener" "blue" {
  load_balancer_arn = aws_alb.ec2-alb-blue.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.front-web-blue.arn
  }
}

# Create HTTP Listener for load balancer green.

resource "aws_alb_listener" "green" {
  load_balancer_arn = aws_alb.ec2-alb-green.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.front-web-green.arn
  }
}



# Back instance target group blue
resource "aws_alb_target_group" "back-instance-blue" {
  name                        = "back-instance-blue"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}

# Back instance target group green
resource "aws_alb_target_group" "back-instance-green" {
  name                        = "back-instance-green"
  port                        = 80
  protocol                    = "HTTP"
  target_type                 = "instance"
  vpc_id                      = "${aws_vpc.main-vpc.id}"
}

# Attach target group to back instance blue

resource "aws_alb_target_group_attachment" "myadmin-blue" {
  target_group_arn            = aws_alb_target_group.back-instance-blue.arn
  target_id                   = aws_instance.back_instance_blue.id
  port                        = 80
}

# Attach target group to back instance green

resource "aws_alb_target_group_attachment" "myadmin-green" {
  target_group_arn            = aws_alb_target_group.back-instance-green.arn
  target_id                   = aws_instance.back_instance_green.id
  port                        = 80
}

# Additional listener rule for /phpmyadmin path blue

resource "aws_alb_listener_rule" "myadmin-listener-blue" {
  listener_arn                = aws_alb_listener.blue.arn
  priority                    = 100

  action {
    type                      = "forward"
    target_group_arn          = aws_alb_target_group.back-instance-blue.arn
  }
  condition {
    path_pattern {
      values                  = ["/phpmyadmin*"]
    }
  }
}


# Additional listener rule for /phpmyadmin path green 

resource "aws_alb_listener_rule" "myadmin-listener-green" {
  listener_arn                = aws_alb_listener.green.arn
  priority                    = 100

  action {
    type                      = "forward"
    target_group_arn          = aws_alb_target_group.back-instance-green.arn
  }
  condition {
    path_pattern {
      values                  = ["/phpmyadmin*"]
    }
  }
}



