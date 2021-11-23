variable "AWS_REGION" {    
    default = "eu-central-1"
}

variable "AWS_AVAIL_ZONE_1" { 
    default = "eu-central-1a"
}

variable "AWS_AVAIL_ZONE_2" { 
    default = "eu-central-1b"
}

variable "AMI" {
    type = map
    
    default = {
        eu-central-1 = "ami-047e03b8591f2d48a"
    }
}

variable "vpc_name" {
  type        = string
  description = "Main VPC 1"
  default = "main-vpc-1"
}



variable "bucket-name" {
  type        = string
  description = "My Bucket"
  default = "arn:aws:s3:::mkrik-bucket"
}

variable "instance-type" {

    type = string
    description = "Instance type"
    default = "t2.micro"
}

variable "key-name" {

    type = string
    description = "SSH Key name"
    default = "ec2-rsa"
}


variable "cloudflare_email" {
    type = string
    description = "Cloudflare account email"
    default = "mishakrik2@gmail.com"
}

variable "cloudflare_key" {
    type = string
    description = "Cloudflare global key"
    default = "349d28b89aaa8f400975df8d792dd43cd0032"
}