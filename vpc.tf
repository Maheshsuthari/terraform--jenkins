provider "aws" {
   region = "${var.region}"
   accesky = "${var.aws_keys[var.acces_key]}"
   secretkey = "${var.aws_keys[var.acces_key]}"
}

data "aws_availability_zones" "azs" {
}
resource "aws_vpc" "my_app" {
  cidr_block  = "10.0.0.0/16"
  instance_tenancy = "default"
  
  tags = {
    Name  = "testing@oracle"
	 }
	Environment = "${terraform.workspace}"
}
locals {
  az_names = "${data.aws_availability_zones.names}"
  pub_sub_ids = "${aws_subnet.public.*.id}"
  
}
resource "aws_subnet" "public" {
 count = "$(length(slice(local.az_names, 0, 2))}"
 vpc_id = "${aws_vpc.my_app.id}"
 cidr_block = "10.0.1.0/24"
 availabilty_zone = "${data.aws_availability_zones.names[count.index]}"
 map_public_ip_on_launch = true
 tags = {
  Name = "PublicSubnet-${count.index + 1}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws.aws_vpc.my_app.id"}
  
  tags = {
    Name = "testing"
    }
}
resource "aws_route_table" "port" {
  vpc_id = "$aws_vpc.my_app.id"}"
  
  route {
    cidr_block = "0.0.0.0/0"
	gateway_id = "${aws_internet_gateway.igw.id}"
   }
	
  tags = {
    Name = "testing"
	}
}
 resource "aws_route_table_association" "pub_sub_asscociate" {
  count          = "${length(local.az_names}"
  subnet_id      = "${local.pub_sub_ids[count.index]}"
  route_table_id = "${aws_route_table.prt.id}"
}

#priivate_subnets

resource "aws_subnet" "private" {
 count = "${length(slice(local.az_names, 0, 2))}"
 vpc_id = "${aws_vpc.my_app.id}"
 cidr_block = "10.0.1.0/24"
 availabilty_zone = "${data.aws_availability_zones.names[count.index]}"
 tags = {
  Name = "PrivateSubnet-${count.index + 1}"
  }
}

resource "aws_instance" "nat" {
 ami = "nat_ami_per_region"
 instance_type = "t2.micro"
 subnet_id = "${local.pub_sub_ids[0]}"
 source_dest_check = false
 #security_group_id = "${aws_security_group.nat_sg.id}"
 vpc_security_group_ids = ["${aws_security_group.nat_sg.id}"]
 tags = {
  name = "testing"
  }
}
resource "aws_route_table" "privatert" {
 vpc_id = "${aws_vpc.my_app.id"}
 
 route {
  cidr_block = "0.0.0.0/0"
  instance_id = "${aws_instance.nat.id}"
  }
  tags = {
    Name = "Testing"
	} 
}
  
resource "aws_route_table_association" "private_rt_association" {
  count = "{length(slice(local.az_names, 0, 2))}"
  subnet_id = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.privatert.id}"
}
resource "aws_security_group" "nat_sg" {
  name        = "nat_sg"
  description = "Allow traffic for subnets traffic"
  vpc_id      = "${aws_vpc.my_app.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${aws_vpc.main.cidr_block}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat_sg"
  }
}