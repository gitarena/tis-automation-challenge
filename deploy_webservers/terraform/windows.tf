#Create instance
resource "aws_instance" "webserver-win" {
  count = 2
  ami = "ami-0d80714a054d3360c"
  instance_type = "t2.micro"
  security_groups = ["sg_webservers"]
  tags = {
    Name = "Web-server-Apache-Windows-${count.index}"
  }
  key_name = "ubuntu"
}

#Create a keypair
resource "aws_key_pair" "webserver_windows" {
  key_name = "windows"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU3FvpHEwefi2nJsWRKnnFRVAkLOPyCqRb8F7QzoVqVm8Bfe8kHzeIVdfmEeuO6SfM51MjDxY5tse3AE0S5Sb7nG6GnHuLQXOjd6IN1iHmB1tMC9Sg0vymtgGqSuPr9Y5RBRGMt9bPgT3aOCDs26WHUOquZ0teYpip0wDiKKJbKinY++tm+KH7r5VBrLVv5G5Iqt/MOb0WPKJz2UFP+Uc3AUAzC7B2k8GAQexVAgksHER9Xc6JgXGjfaeErDMUcp0gNKeGoHCjEXHdZjHuNmoohyK63EWU+mWkIybp2o6mREapMzhQzDLxge8zA6RSwhWXXmPhzYo89Gyn4GjrI5px ec2-user"
}

#Create VPC
resource "aws_vpc" "webserver_windows" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "webserver_windows"
  }
}