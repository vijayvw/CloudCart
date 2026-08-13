resource "aws_db_subnet_group" "mysql" {
  name = "cloudcart-native-rds-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name    = "cloudcart-native-rds-subnet-group"
    Project = var.project_name
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "cloudcart-native-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  storage_type          = "gp3"
  max_allocated_storage = 50

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 3306

  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = false

  storage_encrypted = true

  backup_retention_period = 1

  skip_final_snapshot = true

  tags = {
    Name        = "cloudcart-native-mysql"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
