#!/bin/bash

set -e

exec > >(tee /var/log/cloudcart-user-data.log | logger -t cloudcart-user-data -s 2>/dev/console) 2>&1

echo "========================================="
echo "CloudCart bootstrap started"
echo "========================================="

# ---------------------------------------------------------
# Install dependencies
# ---------------------------------------------------------

apt-get update

apt-get install -y \
  ca-certificates \
  curl \
  mysql-client

# ---------------------------------------------------------
# Install Docker
# ---------------------------------------------------------

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc

chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update

apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

systemctl enable docker
systemctl start docker

# ---------------------------------------------------------
# CloudCart configuration
# ---------------------------------------------------------

mkdir -p /opt/cloudcart

cat > /opt/cloudcart/.env <<EOF
AWS_REGION=${aws_region}

RDS_HOST=${rds_host}
RDS_PORT=${rds_port}
RDS_DB_NAME=${db_name}
RDS_USER=${db_username}
RDS_PASSWORD=${db_password}

DYNAMODB_USERS_TABLE=${dynamodb_table}
DYNAMODB_ENDPOINT=
EOF

chmod 600 /opt/cloudcart/.env

# ---------------------------------------------------------
# Pull CloudCart image
# ---------------------------------------------------------

echo "Pulling CloudCart image..."

docker pull ${docker_image}

# Remove old container if present

docker rm -f cloudcart 2>/dev/null || true

# ---------------------------------------------------------
# Create CloudCart container
# ---------------------------------------------------------

echo "Creating CloudCart container..."

docker create \
  --name cloudcart \
  --restart unless-stopped \
  -p 80:80 \
  --env-file /opt/cloudcart/.env \
  ${docker_image}

# ---------------------------------------------------------
# Extract schema.sql from Docker image
# ---------------------------------------------------------

echo "Extracting database schema..."

docker cp \
  cloudcart:/var/www/html/sql/schema.sql \
  /opt/cloudcart/schema.sql

if [ ! -s /opt/cloudcart/schema.sql ]; then
    echo "ERROR: schema.sql was not found."
    exit 1
fi

echo "Schema extracted successfully."

# ---------------------------------------------------------
# Wait for RDS
# ---------------------------------------------------------

echo "Waiting for RDS..."

until mysql \
  -h "${rds_host}" \
  -P "${rds_port}" \
  -u "${db_username}" \
  -p"${db_password}" \
  "${db_name}" \
  -e "SELECT 1;" >/dev/null 2>&1
do
    echo "RDS is not ready. Waiting 10 seconds..."
    sleep 10
done

echo "RDS is ready."

# ---------------------------------------------------------
# Initialize database
# ---------------------------------------------------------

echo "Checking CloudCart database..."

TABLE_EXISTS=$(mysql \
  -h "${rds_host}" \
  -P "${rds_port}" \
  -u "${db_username}" \
  -p"${db_password}" \
  "${db_name}" \
  -Nse \
  "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${db_name}' AND table_name='products';")

if [ "$TABLE_EXISTS" = "0" ]; then

    echo "Products table does not exist."
    echo "Initializing CloudCart database..."

    mysql \
      -h "${rds_host}" \
      -P "${rds_port}" \
      -u "${db_username}" \
      -p"${db_password}" \
      "${db_name}" < /opt/cloudcart/schema.sql

    echo "Database schema imported successfully."

else

    echo "CloudCart database already initialized."
    echo "Skipping schema import."

fi

# ---------------------------------------------------------
# Start CloudCart
# ---------------------------------------------------------

echo "Starting CloudCart..."

docker start cloudcart

# ---------------------------------------------------------
# Verify
# ---------------------------------------------------------

echo "Checking CloudCart container..."

docker ps --filter "name=cloudcart"

echo "Checking database tables..."

mysql \
  -h "${rds_host}" \
  -P "${rds_port}" \
  -u "${db_username}" \
  -p"${db_password}" \
  "${db_name}" \
  -e "SHOW TABLES;"

echo "========================================="
echo "CloudCart deployment completed"
echo "========================================="
