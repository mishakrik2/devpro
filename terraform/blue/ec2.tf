# Create back instance blue

resource "aws_instance" "back_instance_blue" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.back_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-2.id}"
#user_data                   = "${file("./files/back-bootstrap.sh")}"
associate_public_ip_address = true
key_name                    = var.key-name
tags = {
    Name = "back"
    }
}

# Create back instance green

resource "aws_instance" "back_instance_green" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.back_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-2.id}"
#user_data                   = "${file("./files/back-bootstrap.sh")}"
associate_public_ip_address = true
key_name                    = var.key-name
tags = {
    Name = "back"
    }
}

# Create bastion instance blue

resource "aws_instance" "bastion_instance_blue" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.alb_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-2.id}"
#user_data                   = "${file("./files/back-bootstrap.sh")}"
key_name                    = var.key-name
tags = {
    Name = "bastion"
    }
}

# Create bastion instance green

resource "aws_instance" "bastion_instance_green" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.alb_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-2.id}"
#user_data                   = "${file("./files/back-bootstrap.sh")}"
key_name                    = var.key-name
tags = {
    Name = "bastion"
    }
}

# Create RDS instance

resource "aws_db_instance" "default" {
  db_subnet_group_name = "${aws_db_subnet_group.db.id}"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  vpc_security_group_ids = [aws_security_group.back_sec_group.id]
  name                 = "mydb"
  username             = "user"
  password             = "12345678"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  tags = {
    Name = "db"
    }
}