# CIDR for VPC itself

resource "aws_vpc" "main-vpc" {
    cidr_block = "10.1.0.0/16"
    tags = {
        Name = "${var.vpc_name}"
    }
}

# Main public subnet 1
resource "aws_subnet" "main-subnet-public-1" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true" // defines a public subnet
    availability_zone = "${var.AWS_AVAIL_ZONE_1}"
    tags = {
        Name = "main-subnet-public-1"
    }
}

# Main public subnet 2

resource "aws_subnet" "main-subnet-public-2" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true" // defines a public subnet
    availability_zone = "${var.AWS_AVAIL_ZONE_2}"
    tags = {
        Name = "main-subnet-public-2"
    }
}

# Main private subnet 1

resource "aws_subnet" "main-subnet-private-1" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    cidr_block = "10.1.3.0/24"
    map_public_ip_on_launch = "false" // defines a private subnet
    availability_zone = "${var.AWS_AVAIL_ZONE_1}"
    tags = {
        Name = "main-subnet-private-1"
    }
}

# Main private subnet 2

resource "aws_subnet" "main-subnet-private-2" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    cidr_block = "10.1.4.0/24"
    map_public_ip_on_launch = "false" // defines a private subnet
    availability_zone = "${var.AWS_AVAIL_ZONE_2}"
    tags = {
        Name = "main-subnet-private-2"
    }
}
