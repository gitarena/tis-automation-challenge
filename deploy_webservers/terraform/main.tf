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

[windows:vars]
ansible_user: administrator
ansible_password: L!B?TyuIfksm%$fqKBQCM$TFWql8vud8
ansible_port: 5986
ansible_connection: winrm
EOF
}


resource "null_resource" "provision_webserver_linux" {
  depends_on      = [aws_instance.webserver-linux]
  provisioner "local-exec" {
      command     = "sleep 60 && ansible-playbook -i hosts configure_linux_servers.yml"
      working_dir = "../ansible"  
  }
}

#resource "null_resource" "provision_webserver_windows" {
#  depends_on      = [aws_instance.webserver-win]
#  provisioner "local-exec" {
#      command     = "sleep 30 && ansible-playbook -i hosts configure_windows_servers.yml"
#      working_dir = "../ansible"  
#  }
#}