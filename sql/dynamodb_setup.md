# DynamoDB table setup - KuCL_Users

The users table stores flexible, semi-structured user/profile data
(good NoSQL fit: varying attributes, fast key-value lookups, no joins needed).

## Create via AWS CLI

```bash
aws dynamodb create-table \
    --table-name KuCL_Users \
    --attribute-definitions AttributeName=user_id,AttributeType=S \
    --key-schema AttributeName=user_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ap-south-1
```

## Item shape (example)

```json
{
  "user_id":    "b3f1c2a4-1234-4a2b-9c3d-abcdef123456",
  "name":       "Rohan Sharma",
  "email":      "rohan@example.com",
  "phone":      "+91-9876543210",
  "address": {
    "line1": "12 MG Road",
    "city": "Pune",
    "state": "Maharashtra",
    "pincode": "411001"
  },
  "created_at": "2026-07-01T10:00:00Z"
}
```

Only `user_id` is a fixed key attribute — everything else (address, phone,
loyalty points, wishlist, etc.) can vary per user without a schema migration,
which is the main reason this demo uses DynamoDB for user/profile data
alongside RDS for the structured product/order catalog.

## Alternative: create via PHP (see api/setup_dynamo.php)
Run `php api/setup_dynamo.php` once to create the table programmatically
instead of using the CLI.
