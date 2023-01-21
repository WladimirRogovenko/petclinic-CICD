#======================== for Jenkins node 1 ================================
#defautl VPC
data "aws_vpc" "default-1" {
  default = true #its filter
}                #for read this var: data.aws_vpc.default-1.id

#default SubNet
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-1.id]
  }
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

#create Security Group for 80, 8081, 22 ports
resource "aws_security_group" "secgrp-Linux_80_22" {
  name = "secgrp-Linux_80_22"
  description = "Allow 80 and 22 ports. For Linux web server"
  vpc_id      = data.aws_vpc.default-1.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "${var.env}-secgrp-Linux_80_22"
  }
}


