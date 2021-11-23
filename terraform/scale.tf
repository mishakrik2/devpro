# Get AMI of AWS linux by filter

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

# Create RSA key pair.

resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "ec2-rsa"       # Create key to AWS.
  public_key = tls_private_key.generated.public_key_openssh

  provisioner "local-exec" { # save key to pc.
    command = "echo '${tls_private_key.generated.private_key_pem}' > ./ec2-rsa.pem"
  }
}


# Lauch configuration

resource "aws_launch_configuration" "ec2_launch_config" {
  image_id                    = "${data.aws_ami.amazon-linux-2.id}"
  iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
  security_groups             = ["${aws_security_group.front_sec_group.id}"]
  user_data                   = "${file("./files/front-bootstrap.sh")}"
  instance_type               = var.instance-type
  associate_public_ip_address = false
  key_name                    = var.key-name
}

# Create auto scaling group for launch configuration

resource "aws_autoscaling_group" "ec2_asg" {
  name                 = "ec2-autoscale"
  depends_on           = [aws_launch_configuration.ec2_launch_config]
  launch_configuration = aws_launch_configuration.ec2_launch_config.name
  vpc_zone_identifier  = [aws_subnet.main-subnet-public-1.id, aws_subnet.main-subnet-public-2.id]
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"

    lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

# Attach auto scaling group to target group

resource "aws_autoscaling_attachment" "asg_attachment_alb" {
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.id
  alb_target_group_arn = aws_alb_target_group.front-web.arn
}



