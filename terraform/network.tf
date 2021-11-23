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
