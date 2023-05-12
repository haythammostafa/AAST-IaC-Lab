resource "aws_instance" "instance" {
ami                    = var.ami
instance_type          = var.instance
user_data              = var.ec2_user_data
vpc_security_group_ids = [aws_security_group.aast_sg.id]
#key_name               = aws_key_pair.my_auth.id

tags = {
 Name                  = "AAST-Lab"
}
}

resource "aws_security_group" "aast_sg" { 
vpc_id                 = var.vpc

ingress {
description            = "Allow SSH from my Public IP"
from_port              = 22
to_port                = 22
protocol               = "tcp"
cidr_blocks            = ["0.0.0.0/0"]  
}

ingress {
description            = "Allows Access to the Jenkins Server"
from_port              = 8080
to_port                = 8080
protocol               = "tcp"
cidr_blocks            = ["0.0.0.0/0"]
}

ingress {
description           = "Allows Access to the Jenkins Server"
from_port             = 443
to_port               = 443
protocol              = "tcp"
cidr_blocks           = ["0.0.0.0/0"]
}

egress {
from_port             = 0
to_port               = 0
protocol              = "-1"
cidr_blocks           = ["0.0.0.0/0"]
}
tags = {
  Name                = "AAST Security Group"
}
}

resource "aws_s3_bucket" "bucket" {
bucket                  = "aast-bucket"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


##Create a key pair

/*resource "aws_key_pair" "my_auth" {
key_name = "key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "pub-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "./tf-key-pair"
}
*/

/*resource "aws_key_pair" "my_auth" {
  key_name   = "my_key"
  public_key = file("D:\tf_key.pem")
}*/
