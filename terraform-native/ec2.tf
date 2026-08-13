resource "aws_instance" "app" {
  ami = data.aws_ssm_parameter.ubuntu.value

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  user_data = templatefile("${path.module}/user_data.sh", {
    github_repo   = var.github_repo
    github_branch = var.github_branch

    rds_host    = aws_db_instance.mysql.address
    rds_port    = aws_db_instance.mysql.port
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password

    aws_region     = var.aws_region
    dynamodb_table = aws_dynamodb_table.users.name
  })

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name        = "cloudcart-native-app"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_db_instance.mysql,
    aws_dynamodb_table.users,
    aws_iam_instance_profile.ec2
  ]
}
