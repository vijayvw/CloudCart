resource "aws_dynamodb_table" "users" {
  name         = "Cloud_Users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    Name = "cloud_Users"
  }
}
