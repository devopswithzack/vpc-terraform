output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "public-subnet-a" {
  value = "${aws_subnet.public-subnet-a.id}"
}

output "public-subnet-b" {
  value = "${aws_subnet.public-subnet-b.id}"
}

output "public-subnet-c" {
  value = "${aws_subnet.public-subnet-c.id}"
}

output "aws_internet_gateway" {
  value = "${aws_internet_gateway.gw.id}"
}

output "aws_route_table" {
  value = "${aws_route_table.web-public-rt.id}"
}

output "aws_security_group_netstarter" {
  value = "${aws_security_group.sgns.id}"
}

output "aws_security_group_internal" {
  value = "${aws_security_group.sginternal.id}"
}

output "aws_security_group_public" {
  value = "${aws_security_group.sgpublic.id}"
}

