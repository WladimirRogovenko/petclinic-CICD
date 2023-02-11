#main
#instance for main-srv 
resource "aws_instance" "main-srv" {
  ami           = "ami-03c476a1ca8e3ebdc" #Ubuntu Server 22.04 LTS (HVM), SSD Volume Type  
  instance_type = "t2.micro"
  key_name = "Jenkins-Nodes-key"                # jankins has this key too
  vpc_security_group_ids = [aws_security_group.main-secgrp-Linux_80_22.id]
  subnet_id = sort(data.aws_subnets.default.ids)[0]
  private_ip = var.main-srv-privat_ip  #"172.31.47.3"
  associate_public_ip_address = true

  user_data = file("main-srv_user_data.sh")
  count = var.env == "main"?1:0
  lifecycle {
    //replace_triggered_by = [user_data]
  }
  tags = {
    Name    = "${var.env}-srv"
    env = var.env
  }
}