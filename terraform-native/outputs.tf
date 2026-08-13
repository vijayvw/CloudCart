output "application_url" {
  description = "CloudCart application URL"
  value       = "http://${aws_instance.app.public_ip}"
}

output "ec2_public_ip" {
  description = "CloudCart EC2 public IP"
  value       = aws_instance.app.public_ip
}

output "ec2_public_dns" {
  description = "CloudCart EC2 public DNS"
  value       = aws_instance.app.public_dns
}

output "rds_endpoint" {
  description = "CloudCart RDS endpoint"
  value       = aws_db_instance.mysql.address
}

output "rds_port" {
  description = "CloudCart RDS port"
  value       = aws_db_instance.mysql.port
}

output "dynamodb_table" {
  description = "CloudCart DynamoDB table"
  value       = aws_dynamodb_table.users.name
}

output "vpc_id" {
  description = "CloudCart VPC ID"
  value       = aws_vpc.main.id
}
