terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    local = {
      source  = "hashicorp/local"
    }
    tls = {
      source  = "hashicorp/tls"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "public-key" {
  key_name   = "public-key"
  public_key = tls_private_key.key.public_key_openssh
}
resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.module}/key.pem"
  file_permission = "0600"
}