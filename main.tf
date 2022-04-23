terraform {
  backend "s3" {
    bucket = "terra-bucket-practice"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_instance" "production" {
 ami =      var.ami_image
 instance_type =     var.instance_type
 count =     "1"
 key_name = var.key_name
 security_groups = [aws_security_group.terraform_sg.name]
 tags = {
     "name" =    "terraform-ec2"
 }
  
}

resource "aws_security_group" "terraform_sg" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    description      = "custom"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terraform"
  }
}
  
module "my_databases" {
  source = "./modules/databases"
}

module "my_vpc" {
  source = "./modules/vpc"
  cidr_block = "10.5.0.0/16"
}