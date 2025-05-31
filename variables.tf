variable "aws_region" {}
variable "instance_type" {}
variable "key_name" {
  description = "SSH key name to access EC2"
  type        = string
}

variable "db_name" {}
variable "db_username" {
  description = "Username for RDS MariaDB"
  type        = string
}

variable "db_password" {
  description = "Password for RDS MariaDB"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "Database username"
  type        = string
}

