# Create back instance

resource "aws_instance" "back_instance" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.back_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-1.id}"
user_data                   = "${file("./files/back-bootstrap.sh")}"
associate_public_ip_address = true
key_name                    = var.key-name
tags = {
    Name = "Back instance"
    }
}

# Create bastion instance

resource "aws_instance" "bastion_instance" {
ami                         = "${data.aws_ami.amazon-linux-2.id}"
instance_type               = var.instance-type
iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
vpc_security_group_ids      = [aws_security_group.alb_sec_group.id]
subnet_id                   = "${aws_subnet.main-subnet-public-2.id}"
user_data                   = "${file("./files/back-bootstrap.sh")}"
associate_public_ip_address = true
key_name                    = var.key-name
tags = {
    Name = "Bastion"
    }
}