#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-30628649
#
# Your subnet ID is:#
#     subnet-be42e9f7
#
# Your security group ID is:
#
#     sg-4069a238
#
# Your Identity is:
#
#     RiverIsland-training-moth
#

terraform {
  backend "atlas" {
    name = "jshulver/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-30628649"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-be42e9f7"
  vpc_security_group_ids = ["sg-4069a238"]
  count                  = "${var.num_webs}"

  tags {
    Identity = "RiverIsland-training-moth"
    platform = "test"
    count    = "${count.index}"
  }
}

variable "num_webs" {
  default = "2"
}

variable "aws_access_key" {}

variable "aws_secret_key" {
  description = "shhhhh it's a secret"
}

variable "aws_region" {
  default = "eu-west-1"
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

