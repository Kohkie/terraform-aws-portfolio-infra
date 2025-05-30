output "ec2_public_ip" {
  description = "EC2のパブリックIPアドレス"
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "RDSのエンドポイント"
  value       = aws_db_instance.my_db.endpoint
}

