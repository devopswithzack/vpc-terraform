/* Sample terraform script to create a AWS VPC
 * Contact : www.arshadzackeriya.com, hello@arshadzackeriya.com
 * Developed by Arshad Zackeriya, May 2018
 */

# Define AWS as our provider
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile = "${var.profile}"
}

# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Netstarter Stack VPC"
    Stack = "${var.Stack}"
  }
}

# Define the public subnet az a
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_a}"
  availability_zone = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags {
    Name = "Web Public Subnet AZ A"
    Stack = "${var.Stack}"
  }
}

# Define the public subnet az b
resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_b}"
  availability_zone = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags {
    Name = "Web Public Subnet AZ B"
    Stack = "${var.Stack}"
  }
}

# Define the public subnet az c 
resource "aws_subnet" "public-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_c}"
  availability_zone = "ap-southeast-2c"
  map_public_ip_on_launch = true

  tags {
    Name = "Web Public Subnet AZ C"
    Stack = "${var.Stack}"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC IGW"
    Stack = "${var.Stack}"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
    Stack = "${var.Stack}"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt-a" {
  subnet_id = "${aws_subnet.public-subnet-a.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

resource "aws_route_table_association" "web-public-rt-b" {
  subnet_id = "${aws_subnet.public-subnet-b.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

resource "aws_route_table_association" "web-public-rt-c" {
  subnet_id = "${aws_subnet.public-subnet-c.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Define the security group for allow access.
resource "aws_security_group" "sgns" {
  name = "sg_ns_access"
  description = "Allow SSH access From NS"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["123.123.123.123/32"] 
    #change the ip with your IP address and you can ave multiple ingress blocks.
  }
    
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}


  vpc_id="${aws_vpc.default.id}"

  tags {
    Name = "Netstarter Access"
    Stack = "${var.Stack}"
  }
}

# Define the security group for private access
resource "aws_security_group" "sginternal"{
  name = "sg_internal_access"
  description = "Allow traffic from internal access"

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}


  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Internal Access"
    Stack = "${var.Stack}"
  }
}

# Define the security group for public access
resource "aws_security_group" "sgpublic"{
  name = "sg_public_access"
  description = "Allow traffic from public access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}


  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Public Access"
    Stack = "${var.Stack}"
  }
}