resource "aws_security_group" "ec2" {
  name        = "cloudcart-native-ec2-sg"
  description = "CloudCart native PHP EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from current IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cloudcart-native-ec2-sg"
    Project = var.project_name
  }
}

resource "aws_security_group" "rds" {
  name        = "cloudcart-native-rds-sg"
  description = "CloudCart native RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from CloudCart EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cloudcart-native-rds-sg"
    Project = var.project_name
  }
}
