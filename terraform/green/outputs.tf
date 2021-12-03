output "back_instance_public_ip" {
      description = "Public IP address of the EC2 instance"  
      value       = aws_instance.back_instance.public_ip
}


output "bastion_instance_public_ip" {
      description = "Public IP address of the EC2 instance"  
      value       = aws_instance.bastion_instance.public_ip
}

output "alb_dns_name" {
      description = "DNS name of load balancer"
      value       = aws_alb.ec2-alb.dns_name
}
