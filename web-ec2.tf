locals {
    env_tag = {
        Environment = "${terraform.workspace}"
    }
    web_tags = "${merge(var.web_tags, local.env_tag)}"
}
resource "aws_security_group" "web_sg" {
    name = "web_seg"
    description = "Allow traffic for web apps in ec2"
    vpc_id = "${aws_vpc.my_app.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "web" {
    count  = "${var.ec2_instance_count}"
    ami   = "${var.web_amis[var.region]}"
    instance_type = "${var.ec2_instance_type}"
    subnet_id = "${local.pub_sub_ids[count.index]}"
    tags = "${var.web_tags}"
    user_data = "${file("scripts/apache.sh")}"
    iam_instance_profile = "{aws_iam_instance_profile.s3_ec2_profile.name}"
    vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
    key_name = "${aws_key_pair.web.name}"
}

resource "aws_key_pair" "web" {
    key_name = "testing_web"
    public_key = "$file{"scripts/web.pub")}"
}
