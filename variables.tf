## Defining the variables here.

variable "region" {
    default = "ap-southeast-2"
    #change with your region.
}

variable "shared_credentials_file" {
  default = "/home/user/.aws/credentials"
}

variable "profile" {
  default = "aws-account-profile"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_a" {
  description = "CIDR for the public subnet zone a"
  default = "10.0.1.0/24"
}

variable "public_subnet_b" {
  description = "CIDR for the public subnet zone b"
  default = "10.0.2.0/24"
}

variable "public_subnet_c" {
  description = "CIDR for the public subnet zone c"
  default = "10.0.3.0/24"
}

###########################################################
####      Defining the Tags                               
###########################################################

variable "Stack" {
  default = "stack-name"
}


