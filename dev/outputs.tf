# outputs vars

output "env" {
  description = "Name of project"
    value     = var.env  # dev / prod / test
}

output "aws_region" {
  description = "Current AWS region"
  value     = var.aws_region
}


output "aws_vpc_id" {
  description = "Current VPC"
  value     = data.aws_vpc.default-1.id
}

output "aws_subnet_id" {
  description = "Current Subnet in VPC"
  value     = sort(data.aws_subnets.default.ids)[0]
}

output "aws_security_group_id" {
  description = "Create new SG with ports 80,22"
  value     = aws_security_group.secgrp-Linux_80_22.id
}

output "aws_instance_Jenkins-node_public_ip" {
  description = "Public IP address of Jenkins-node agent instance"
  value     = aws_instance.jenkins-node-1.public_ip
}

output "aws_instance_Jenkins-node_private_ip" {
  description = "Private IP address of Jenkins-node agent instance"
  value = aws_instance.jenkins-node-1.private_ip
}

output "aws_instance_dev-srv_public_ip" {
  description = "Public IP address of Jenkins-node agent instance"
  value     = aws_instance.dev-srv[0].public_ip
}

output "aws_instance_dev-srv_private_ip" {
  description = "Private IP address of Jenkins-node agent instance"
  value = aws_instance.dev-srv[0].private_ip
}