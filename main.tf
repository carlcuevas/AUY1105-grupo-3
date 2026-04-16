terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. VPC (CIDR 10.1.0.0/16)
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "AUY1105-proyecto1-vpc"
  }
}

# 2. Subred (/24)
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  tags = {
    Name = "AUY1105-proyecto1-subnet"
  }
}

# 3. Security Group (Solo SSH)
resource "aws_security_group" "allow_ssh" {
  name        = "AUY1105-proyecto1-sg"
  description = "Permitir trafico SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH restringido"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. AMI Ubuntu 24.04 LTS
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# 5. Instancia EC2 (t2.micro)
resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu_24_04.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "AUY1105-proyecto1-ec2"
  }
}
