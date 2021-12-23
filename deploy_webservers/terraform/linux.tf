resource "aws_instance" "webserver-linux" {
  count = 2
  ami = "ami-0e472ba40eb589f49"
  instance_type = "t2.micro"
  security_groups = ["sg_jenkins"]
  tags = {
    Name = "Web-server-Apache-Linux-${count.index}"
  }
  key_name = "ubuntu"
}

resource "aws_key_pair" "webserver_linux" {
  key_name = "apache"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU3FvpHEwefi2nJsWRKnnFRVAkLOPyCqRb8F7QzoVqVm8Bfe8kHzeIVdfmEeuO6SfM51MjDxY5tse3AE0S5Sb7nG6GnHuLQXOjd6IN1iHmB1tMC9Sg0vymtgGqSuPr9Y5RBRGMt9bPgT3aOCDs26WHUOquZ0teYpip0wDiKKJbKinY++tm+KH7r5VBrLVv5G5Iqt/MOb0WPKJz2UFP+Uc3AUAzC7B2k8GAQexVAgksHER9Xc6JgXGjfaeErDMUcp0gNKeGoHCjEXHdZjHuNmoohyK63EWU+mWkIybp2o6mREapMzhQzDLxge8zA6RSwhWXXmPhzYo89Gyn4GjrI5px ec2-user"
}

resource "aws_vpc" "webserver_linux" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "webserver_linux"
  }
}