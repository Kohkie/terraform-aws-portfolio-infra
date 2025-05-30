<<<<<<< HEAD

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
=======
# プロバイダー設定
provider "aws" {
  region = "ap-northeast-1"  # 東京リージョン
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# パブリックサブネット
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "public-subnet-2"
  }
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# ルートテーブル
resource "aws_route_table" "public_rt" {
>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
<<<<<<< HEAD
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
=======
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# サブネットとルートテーブルの関連付け
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# EC2用セキュリティグループ
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow EC2 traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

<<<<<<< HEAD
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

=======
>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

<<<<<<< HEAD
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
=======
# RDS用セキュリティグループ
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allow RDS traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
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

# EC2インスタンス
resource "aws_instance" "web" {
  ami                    = "ami-06cd52961ce9f0d85"  # Amazon Linux 2 の有効なAMIに修正
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "MyEC2"
  }
}

# RDS（MariaDB）
resource "aws_db_instance" "my_db" {
  identifier              = "mydb"
  engine                  = "mariadb"
  engine_version          = "10.6"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_user
  password                = var.db_password
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name

  tags = {
    Name = "MyRDSInstance"
  }
}

# RDS用のサブネットグループ
resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.public.id, aws_subnet.public2.id]

  tags = {
    Name = "Main DB Subnet Group"
  }
}

# S3 バケット（バックアップ用途）
resource "aws_s3_bucket" "backup" {
  bucket = "backup-bucket-kohki-terraform-20240529"
  acl    = "private"
}

>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
