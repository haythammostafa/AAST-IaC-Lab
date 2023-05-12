variable "vpc" {
  description         = "The Default VPC of EC2"
  type                = string
  default             = "vpc-45669c38"
}

variable "ami" {
  description         = "The AMI ID of the Instance"
  type                = string
  default             = "ami-0889a44b331db0194"
}

variable "instance" {
  description         = "The Instance Type of EC2"
  type                = string
  default             = "t2.micro"
}

variable "ec2_user_data" {
  description        = "User Data for AAST EC2"
  type               = string
  default            = <<-EOF
  #!/bin/bash
  touch /home/ec2-user/welcome.txt
  echo "Welcome To AAST" >> /home/ec2-user/welcome.txt
  EOF
}