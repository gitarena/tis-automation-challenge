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

resource "null_resource" "provision_jenkins" {
  depends_on      = [aws_instance.jenkins]
  provisioner "local-exec" {
      command     = "sleep 30 && ansible-playbook install_jenkins.yml"
      working_dir = "../ansible"  
  }
}