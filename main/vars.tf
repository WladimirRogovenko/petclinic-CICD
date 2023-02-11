#main


variable "env" {
  description = "Name of enviroupment"
  type        = string
  default     = "main"  # dev / main
}

variable "aws_region" {
  description = "Current AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "main-srv-privat_ip" {
  description = "static IP address for main-srv"
  type        = string
  default     = "172.31.47.3"
}