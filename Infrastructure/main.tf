resource "aws_vpc" "VPC1" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "bobbascloud-vpc-1"
    }
}

resource "aws_subnet" "public_1" {
  cidr_block = var.public_1_cidr
  vpc_id = aws_vpc.VPC1.id
  availability_zone = "ap-south-1a"
     map_public_ip_on_launch = true
     tags = {
        name = var.public_1_name
     }
}

resource "aws_subnet" "public_2" {
  cidr_block = var.public_2_cidr
  vpc_id = aws_vpc.VPC1.id
   availability_zone = "ap-south-1a"
     map_public_ip_on_launch = true
     tags = {
        name = var.public_2_name
     }
}

resource "aws_subnet" "private_1" {
  cidr_block = var.private_1_cidr
  vpc_id = aws_vpc.VPC1.id
   availability_zone = "ap-south-1a"
     map_public_ip_on_launch = true
     tags = {
        name = var.private_1_name
     }
}

resource "aws_subnet" "private_2" {
  cidr_block = var.private_2_cidr
  vpc_id = aws_vpc.VPC1.id
   availability_zone = "ap-south-1a"
     map_public_ip_on_launch = true
     tags = {
        name = var.private_2_name
     }
}

resource "aws_internet_gateway" "aws_IGW" {
     vpc_id = aws_vpc.VPC1.id
     tags = {
        name = var.IGW
     }
}

resource "aws_route_table" "aws_pub_rt" {
    vpc_id = aws_vpc.VPC1.id
}

resource "aws_route_table" "aws_pri_rt" {
    vpc_id = aws_vpc.VPC1.id
}

resource "aws_route_table_association" "pub_1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.aws_pub_rt.id
}
resource "aws_route_table_association" "priv_1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.aws_pri_rt.id
}
resource "aws_route_table_association" "pub_2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.aws_pub_rt.id
}
resource "aws_route_table_association" "priv_2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.aws_pri_rt.id
}

resource "aws_route" "main_route" {
    route_table_id = aws_route_table.aws_pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id =  aws_internet_gateway.aws_IGW.id   
}