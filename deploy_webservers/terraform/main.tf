terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Save state in S3 bucket
terraform{
    backend "s3"{
      bucket = "arena123"
      key    = "web-servers.tfstate"
      region = "us-east-1"
    }
}

resource "local_file" "inventory" {
 filename = "../ansible/hosts"
 content = <<EOF
[linux]
${aws_instance.webserver-linux[0].public_ip}
${aws_instance.webserver-linux[1].public_ip}

[windows]
${aws_instance.webserver-win[0].public_ip}
${aws_instance.webserver-win[1].public_ip}
EOF
}


resource "null_resource" "provision_webserver_linux" {
  provisioner "local-exec" {
      command     = "sleep 30 && ansible-playbook -i hosts configure_linux_servers.yml"
      working_dir = "../ansible"  
  }
}