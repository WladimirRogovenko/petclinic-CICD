#dev


variable "env" {
  description = "Name of enviroupment"
  type        = string
  default     = "dev"  # dev / prod 
}

variable "aws_region" {
  description = "Current AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "jenkins-node-1-privat_ip" {
  description = "static IP address for Jenkins node 1"
  type        = string
  default     = "172.31.47.1"
}

variable "dev-srv-privat_ip" {
  description = "static IP address for dev-srv"
  type        = string
  default     = "172.31.47.2"
}