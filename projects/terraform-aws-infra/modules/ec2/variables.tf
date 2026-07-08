variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet to launch the instance into"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "environment" {
  description = "Environment name used for tagging"
  type        = string
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access"
  type        = string
  default     = null
}
