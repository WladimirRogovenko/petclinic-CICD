#create Instance Jenkins-Node-1
resource "aws_instance" "jenkins-node-1" {
  ami           = "ami-03c476a1ca8e3ebdc" #Ubuntu Server 22.04 LTS (HVM), SSD Volume Type       #"ami-0493936afbe820b28"  # Ubuntu 20.04 server
  instance_type = "t3.small" #"t2.micro"
  key_name = "Jenkins-Nodes-key"                # jankins has this key too
  vpc_security_group_ids = [aws_security_group.secgrp-Linux_80_22.id]
  subnet_id = sort(data.aws_subnets.default.ids)[0]
  private_ip = var.jenkins-node-1-privat_ip    #"172.31.47.1"
  associate_public_ip_address = true

  user_data = file("jenkins-node_user_data.sh")
  lifecycle {
    //replace_triggered_by = [user_data]
  }
  tags = {
    Name    = "${var.env}-Jenkins-Node-srv"
    env = var.env
  }
}

#instance for dev-Server 
resource "aws_instance" "dev-srv" {
  ami           = "ami-03c476a1ca8e3ebdc" #Ubuntu Server 22.04 LTS (HVM), SSD Volume Type  
  instance_type = "t2.micro"
  key_name = "Jenkins-Nodes-key"                # jankins has this key too
  vpc_security_group_ids = [aws_security_group.secgrp-Linux_80_22.id]
  subnet_id = sort(data.aws_subnets.default.ids)[0]
  private_ip = var.dev-srv-privat_ip  #"172.31.47.2"
  associate_public_ip_address = true

  user_data = file("dev-srv_user_data.sh")
  count = var.env == "dev"?1:0
  lifecycle {
    //replace_triggered_by = [user_data]
  }
  tags = {
    Name    = "${var.env}-srv"
    env = var.env
  }
}