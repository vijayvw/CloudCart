resource "aws_iam_role" "ec2" {
  name = "cloudcart-native-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "dynamodb" {
  name = "cloudcart-native-dynamodb-policy"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ]

      Resource = aws_dynamodb_table.users.arn
    }]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "cloudcart-native-ec2-profile"
  role = aws_iam_role.ec2.name
}
