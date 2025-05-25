
variable "key_name" {
  description = "SSH key name to access EC2"
  type        = string
}

variable "db_username" {
  description = "Username for RDS MariaDB"
  type        = string
}

variable "db_password" {
  description = "Password for RDS MariaDB"
  type        = string
  sensitive   = true
}
