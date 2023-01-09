#create Instance Jenkins-Node-1
resource "aws_instance" "jenkins-node-1" {
  ami           = "ami-03c476a1ca8e3ebdc" #Ubuntu Server 22.04 LTS (HVM), SSD Volume Type       #"ami-0493936afbe820b28"  # Ubuntu 20.04 server
  instance_type = "t2.micro"
  key_name = "Jenkins-Nodes-key"                # jankins has this key too
  vpc_security_group_ids = [aws_security_group.secgrp-Linux_80_22.id]
  subnet_id = sort(data.aws_subnets.default.ids)[0]
  private_ip = "172.31.47.1"
  associate_public_ip_address = true

  user_data = file("jenkins-node_user_data.sh")
  tags = {
    Name    = "${var.env}-Jenkins-Node-srv"
    env = var.env
  }
}

#there may be instance for Server Java (dev or prod)