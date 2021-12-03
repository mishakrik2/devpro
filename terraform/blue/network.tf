# Init main AWS Internet gateway.
resource "aws_internet_gateway" "main-igw" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    tags = {
        Name = "main-igw"
    }
}

# Init main gateway tables for public networks
resource "aws_route_table" "main-public-crt" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    
    route {
        # Reachable for anyone from outside.
        cidr_block = "0.0.0.0/0" 
        # Use main gateway to access Internet.
        gateway_id = "${aws_internet_gateway.main-igw.id}" 
    }
    
    tags = {
        Name = "main-public-crt"
    }
}

# Get elastic IP for NAT

#  vpc        = true
#  depends_on = [aws_internet_gateway.main-igw]
#}

# Create NAT gateway for private subnet

#resource "aws_nat_gateway" "nat-priv-1" {
#  allocation_id = "${aws_eip.nat_eip.id}"
#  subnet_id     = "${aws_subnet.main-subnet-private-1.id}"
#  depends_on    = [aws_internet_gateway.main-igw]
#  tags = {
#    Name        = "NAT"
#  }
#}

#resource "aws_nat_gateway" "nat-priv-2" {
#  allocation_id = "${aws_eip.nat_eip.id}"
#  subnet_id     = "${aws_subnet.main-subnet-private-2.id}"
#  depends_on    = [aws_internet_gateway.main-igw]
#  tags = {
#    Name        = "NAT"
#  }
#}


# Main gateway tables for private networks

#resource "aws_route_table" "main-private-crt" {
#    vpc_id = "${aws_vpc.main-vpc.id}"
    
   # route {
   #     # Reachable for anyone from outside.
   #     cidr_block = "0.0.0.0/0" 
   #     # Use main gateway to access Internet.
   #     gateway_id = "${aws_internet_gateway.main-igw.id}" 
   # }
    
#    tags = {
#        Name = "main-private-crt"
#    }
#}

# Route for public networks
#resource "aws_route" "internet_pub" {
#  route_table_id          = aws_route_table.main-public-crt.id
#  destination_cidr_block  = "0.0.0.0/0"
#  gateway_id              = aws_internet_gateway.main-igw.id
#}

#

#resource "aws_route" "private_nat_gateway" {
#  route_table_id         = "${aws_route_table.private.id}"
#  destination_cidr_block = "0.0.0.0/0"
#  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
#}

# Associate route tables for Public subnet 1

resource "aws_route_table_association" "main-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.main-subnet-public-1.id}"
    route_table_id = "${aws_route_table.main-public-crt.id}"
}

# for Public subnet 2

resource "aws_route_table_association" "main-crta-public-subnet-2"{
    subnet_id = "${aws_subnet.main-subnet-public-2.id}"
    route_table_id = "${aws_route_table.main-public-crt.id}"
}

# for Private subnet 1

#resource "aws_route_table_association" "main-crta-private-subnet-1"{
#    subnet_id = "${aws_subnet.main-subnet-private-1.id}"
#    route_table_id = "${aws_route_table.main-private-crt.id}"
#}

# for Private subnet 2

#resource "aws_route_table_association" "main-crta-private-subnet-2"{
#    subnet_id = "${aws_subnet.main-subnet-private-2.id}"
#    route_table_id = "${aws_route_table.main-private-crt.id}"
#}




#test