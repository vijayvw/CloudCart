resource "aws_db_subnet_group" "mysql" {
  name = "cloud-rds-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name = "cloud-rds-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "cloud-cart"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  multi_az = false

  backup_retention_period = 1

  deletion_protection = false

  skip_final_snapshot = true

  auto_minor_version_upgrade = true

  tags = {
    Name = "cloud-rds-mysql"
  }
}
