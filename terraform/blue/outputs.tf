# Output the ACM certificate ARN.

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

##############
# Blue group #
##############

output "back_instance_public_ip_blue" {
      description = "Public IP address of the EC2 instance blue"  
      value       = aws_instance.back_instance_blue.public_ip
}


output "bastion_instance_public_ip_blue" {
      description = "Public IP address of the EC2 instance blue"  
      value       = aws_instance.bastion_instance_blue.public_ip
}

output "alb_dns_name_blue" {
      description = "DNS name of load balancer blue"
      value       = aws_alb.ec2-alb-blue.dns_name
}

###############
# Green group #
###############

output "back_instance_public_ip_green" {
      description = "Public IP address of the EC2 instance green"  
      value       = aws_instance.back_instance_green.public_ip
}


output "bastion_instance_public_ip_green" {
      description = "Public IP address of the EC2 instance green"  
      value       = aws_instance.bastion_instance_green.public_ip
}

output "alb_dns_name_green" {
      description = "DNS name of load balancer green"
      value       = aws_alb.ec2-alb-green.dns_name
}

output "rds_public_ip" {
      description = "RDS instance public IP"
      value       = aws_db_instance.default.public_ip
}
