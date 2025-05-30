<<<<<<< HEAD

variable "key_name" {
  description = "SSH key name to access EC2"
  type        = string
}

variable "db_username" {
  description = "Username for RDS MariaDB"
=======
variable "db_user" {
  description = "RDSのユーザー名"
>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
  type        = string
}

variable "db_password" {
<<<<<<< HEAD
  description = "Password for RDS MariaDB"
  type        = string
  sensitive   = true
}
=======
  description = "RDSのパスワード"
  type        = string
  sensitive   = true  # terraform planやapply時にパスワードが見えなくなる
}

>>>>>>> 9aab8bf (Initial commit with .gitignore and Terraform configs)
