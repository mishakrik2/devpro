# Excessive rules from this block will be removed later.
# Default security group.

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.main-vpc.id}"
}

# Front security group
resource "aws_security_group" "front_sec_group" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  name   = "Front Application Security Group"
}

resource "aws_security_group_rule" "front_egress_http" {
  type             = "egress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_egress_ssh" {
  type             = "egress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_egress_mysql" {
  type             = "egress"
  from_port        = 3306
  to_port          = 3306
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_egress_tls" {
  type             = "egress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}


resource "aws_security_group_rule" "front_ingress_http" {
  type             = "ingress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_ingress_ssh" {
  type             = "ingress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_ingress_mysql" {
  type             = "ingress"
  from_port        = 3306
  to_port          = 3306
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

resource "aws_security_group_rule" "front_ingress_tls" {
  type             = "ingress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.front_sec_group.id
}

# Back security group

resource "aws_security_group" "back_sec_group" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  name   = "Back Application Security Group"
}

resource "aws_security_group_rule" "back_egress_http" {
  type             = "egress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_egress_ssh" {
  type             = "egress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_egress_mysql" {
  type             = "egress"
  from_port        = 3306
  to_port          = 3306
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_egress_tls" {
  type             = "egress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_ingress_http" {
  type             = "ingress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_ingress_ssh" {
  type             = "ingress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_ingress_mysql" {
  type             = "ingress"
  from_port        = 3306
  to_port          = 3306
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

resource "aws_security_group_rule" "back_ingress_tls" {
  type             = "ingress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.back_sec_group.id
}

# Application load balancer security group


resource "aws_security_group" "alb_sec_group" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  name   = "Application Load Balancer Security Group"
}

resource "aws_security_group_rule" "alb_egress_http" {
  type             = "egress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}

resource "aws_security_group_rule" "alb_egress_ssh" {
  type             = "egress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}

resource "aws_security_group_rule" "alb_egress_tls" {
  type             = "egress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}

resource "aws_security_group_rule" "alb_ingress_http" {
  type             = "ingress"
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}

resource "aws_security_group_rule" "alb_ingress_ssh" {
  type             = "ingress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}

resource "aws_security_group_rule" "alb_ingress_tls" {
  type             = "ingress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  #ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.alb_sec_group.id
}