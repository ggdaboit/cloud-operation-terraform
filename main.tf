terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "sa-east-1"
}

#ec2
resource "aws_instance" "ec2-terraform" {
  #instanceType
  ami           = "ami-037c192f0fa52a358"
  instance_type = "t3a.micro"
  monitoring = true
  disable_api_termination = true
  #network
  subnet_id = "subnet-0216765efeeff8627"
  associate_public_ip_address = true
  #secgroup
  security_groups = ["sg-010a149e899bf66a3"]
  #keypair
  key_name = "Gille-Keypair"
  #storage
  ebs_optimized = false
  root_block_device {
    volume_type = "gp3"
    volume_size = "20"
    }
  #tags
  tags = {
    Name = "EC2 - Terraform"
    Environment = "Dev"
  }
}

#aws_s3
resource "aws_s3_bucket" "bucket-terraform" {
  #name
  bucket = "bucket-terraform-${data.aws_caller_identity.current.account_id}"
  force_destroy = "false"
  #acl
  acl = "private"
  #tags
  tags = {
    Name        = "bucket-terraform"
    Environment = "Dev"
  }
}

#aws_account_id
data "aws_caller_identity" "current" {}
