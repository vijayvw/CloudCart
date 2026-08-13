data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_instance" "app" {
  ami           = data.aws_ssm_parameter.ubuntu.value
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  key_name = var.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  user_data = templatefile("${path.module}/user_data.sh", {
    docker_image   = var.docker_image
    rds_host       = aws_db_instance.mysql.address
    rds_port       = aws_db_instance.mysql.port
    db_name        = var.db_name
    db_username    = var.db_username
    db_password    = var.db_password
    aws_region     = var.aws_region
    dynamodb_table = aws_dynamodb_table.users.name
  })

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "Cloud-Cart-Server"
  }

  depends_on = [
    aws_db_instance.mysql,
    aws_dynamodb_table.users
  ]
}
