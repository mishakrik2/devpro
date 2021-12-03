variable "AWS_REGION" {    
    default = "eu-west-2"
}

variable "AWS_AVAIL_ZONE_1" { 
    default = "eu-west-2a"
}

variable "AWS_AVAIL_ZONE_2" { 
    default = "eu-west-2b"
}

variable "vpc_name" {
  type        = string
  description = "Main VPC 1 Fallback"
  default = "main-vpc-1-fallback"
}

variable "bucket-name" {
  type        = string
  description = "My Bucket"
  default = "arn:aws:s3:::mkrik-bucket"
}

variable "AMI" {
    type = map
    
    default = {
        eu-central-1 = "ami-047e03b8591f2d48a"
    }
}

variable "instance-type" {

    type = string
    description = "Instance type"
    default = "t2.micro"
}

variable "key-name" {

    type = string
    description = "SSH Key name"
    default = "ec2-rsa-fallback"
}