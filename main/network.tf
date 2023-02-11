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

#create Security Group for 80, 22 ports
resource "aws_security_group" "main-secgrp-Linux_80_22" {
  name = "main-secgrp-Linux_80_22"
  description = "Allow 80 and 22 ports. For Linux web server"
  vpc_id      = data.aws_vpc.default-1.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8 #this strange syntax to allow ping
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["172.31.32.0/20"]
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


