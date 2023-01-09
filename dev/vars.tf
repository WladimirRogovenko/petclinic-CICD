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

