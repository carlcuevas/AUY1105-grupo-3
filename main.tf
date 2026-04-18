terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# =============================================================================
# 1. VPC
# -----------------------------------------------------------------------------
# Virtual Private Cloud aislada para alojar la infraestructura del proyecto.
# CIDR 10.1.0.0/16 según requerimiento de la pauta.
# =============================================================================
resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "AUY1105-proyecto1-vpc"
    Project     = "AUY1105-proyecto1"
    ManagedBy   = "Terraform"
  }
}

# =============================================================================
# 2. Subred pública (/24)
# -----------------------------------------------------------------------------
# Segmento de red /24 dentro de la VPC para los recursos de cómputo.
# =============================================================================
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "AUY1105-proyecto1-sn-pub"
    Project     = "AUY1105-proyecto1"
    ManagedBy   = "Terraform"
  }
}

# =============================================================================
# 3. Security Group
# -----------------------------------------------------------------------------
# Controla el tráfico entrante y saliente. Solo permite SSH entrante desde
# el bloque CIDR de la propia VPC (10.1.0.0/16), cumpliendo la política OPA
# que prohíbe SSH abierto a 0.0.0.0/0.
# =============================================================================
resource "aws_security_group" "allow_ssh" {
  name        = "AUY1105-proyecto1-sg"
  description = "Permite trafico SSH restringido al bloque de la VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH desde la VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    description = "Trafico saliente permitido"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "AUY1105-proyecto1-sg"
    Project     = "AUY1105-proyecto1"
    ManagedBy   = "Terraform"
  }
}

# =============================================================================
# 4. AMI Ubuntu 24.04 LTS
# -----------------------------------------------------------------------------
# Busca la AMI oficial más reciente de Ubuntu Server 24.04 LTS (Noble) para
# la arquitectura amd64 propiedad de Canonical (ID 099720109477).
# =============================================================================
data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# =============================================================================
# 5. Instancia EC2
# -----------------------------------------------------------------------------
# Instancia de cómputo t2.micro (tipo permitido por política OPA) con la AMI
# de Ubuntu 24.04 LTS, desplegada en la subred pública y asociada al SG.
# =============================================================================
resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu_24_04.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name        = "AUY1105-proyecto1-ec2"
    Project     = "AUY1105-proyecto1"
    ManagedBy   = "Terraform"
  }
}
