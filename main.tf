
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "instance" {
  name        = "instance-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-0ed99df77a82560e6" # Ubuntu 22.04 Tokyo
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = var.key_name

  tags = {
    Name = "PortfolioUbuntuServer"
  }
}

resource "aws_db_instance" "mariadb" {
  allocated_storage    = 20
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t3.micro"
  name                 = "portfolio_db"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mariadb10.6"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.instance.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

resource "aws_db_subnet_group" "default" {
  name       = "portfolio-db-subnet-group"
  subnet_ids = [aws_subnet.public.id]

  tags = {
    Name = "Portfolio DB Subnet Group"
  }
}

resource "aws_s3_bucket" "backup" {
  bucket = "portfolio-backup-${random_id.bucket_id.hex}"
  force_destroy = true

  tags = {
    Name = "Portfolio Backup Bucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
