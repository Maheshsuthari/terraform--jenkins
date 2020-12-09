variable "vpc_cidr" {
  description = "choose cidr for vpc"
  type = "string"
  default = "10.0.0.0/16"
  }
variable "region" {
  description = "choose region for you check
  type = "string"
  default = "us-east-1"
  }
variable "nat_amis" {
  type = "map"
  default = {
    us-east-1 = "ami1-os-ubuntu"
	us-east-2 = "ami2-os-ubutn"
	}
 }
variable "aws_keys" {
  type = "map"
  default = {
   access_key = {}
   secretkey = {}
  }
}
variable "ec2_amis" {
  type = "map"
  default = {
    us-east-1 = "ami1-os-ubuntu"
	us-east-2 = "ami2-os-ubutn"
	}
 }
variable "ec2_instance_count" {
    description = "enter instance count for ec2"
    type = "string"
    default = "2"
}
variable "ec2_instance_type" {
    description = "choose instance type for ec2"
    type = "string"
    default = "t2.small"
}
variable "ec2_tags" {
    type = "map"
    default = {
        Name = "webserver"
        Environment = "dev"
    }
}