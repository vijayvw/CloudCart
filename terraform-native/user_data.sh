#!/bin/bash

set -euo pipefail

# =========================================================
# CloudCart - Native AWS EC2 PHP Deployment
#
# Deployment:
#   Terraform -> EC2 -> Apache -> PHP -> RDS + DynamoDB
#
# NO DOCKER
# =========================================================

LOG_FILE="/var/log/cloudcart-native-user-data.log"

exec > >(tee -a "$LOG_FILE" | logger -t cloudcart-native -s 2>/dev/console) 2>&1

echo "================================================="
echo "CloudCart Native PHP Deployment"
echo "Started: $(date)"
echo "================================================="

# =========================================================
# Terraform-provided values
# =========================================================

APP_DIR="/var/www/cloudcart"

REPO="${github_repo}"
BRANCH="${github_branch}"

RDS_HOST="${rds_host}"
RDS_PORT="${rds_port}"
DB_NAME="${db_name}"
DB_USER="${db_username}"
DB_PASSWORD="${db_password}"

AWS_REGION="${aws_region}"
DYNAMODB_TABLE="${dynamodb_table}"

# =========================================================
# Basic validation
# =========================================================

if [ -z "$REPO" ]; then
    echo "ERROR: GitHub repository is empty."
    exit 1
fi

if [ -z "$RDS_HOST" ]; then
    echo "ERROR: RDS host is empty."
    exit 1
fi

if [ -z "$DB_PASSWORD" ]; then
    echo "ERROR: RDS password is empty."
    exit 1
fi

echo "Repository : $REPO"
echo "Branch     : $BRANCH"
echo "RDS Host   : $RDS_HOST"
echo "Database   : $DB_NAME"
echo "AWS Region : $AWS_REGION"
echo "DynamoDB   : $DYNAMODB_TABLE"

# =========================================================
# Update Ubuntu
# =========================================================

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get upgrade -y

# =========================================================
# Install required packages
# =========================================================

apt-get install -y \
    apache2 \
    git \
    curl \
    unzip \
    mysql-client \
    php \
    php-cli \
    php-common \
    php-mysql \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-intl \
    php-bcmath \
    libapache2-mod-php

# =========================================================
# Enable Apache
# =========================================================

systemctl enable apache2
systemctl start apache2

# =========================================================
# Verify PHP
# =========================================================

echo "PHP version:"
php -v

echo "PHP modules:"
php -m

# ---------------------------------------------------------
# Install Composer
# ---------------------------------------------------------

echo "Installing Composer..."

export HOME=/root
export COMPOSER_HOME=/root/.composer

EXPECTED_SIGNATURE="$(curl -fsSL https://composer.github.io/installer.sig)"

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
    echo "ERROR: Composer installer signature verification failed."
    rm -f composer-setup.php
    exit 1
fi

php composer-setup.php \
    --install-dir=/usr/local/bin \
    --filename=composer

rm -f composer-setup.php

export PATH="/usr/local/bin:$PATH"

composer --version

echo "Composer installation completed."

# =========================================================
# Prepare application directory
# =========================================================

echo "Preparing application directory..."

rm -rf "$APP_DIR"

mkdir -p "$APP_DIR"

# =========================================================
# Clone CloudCart from GitHub
# =========================================================

echo "Cloning CloudCart..."

git clone \
    --depth 1 \
    --branch "$BRANCH" \
    "$REPO" \
    "$APP_DIR"

cd "$APP_DIR"

echo "Application files:"
ls -la

# =========================================================
# Verify required application files
# =========================================================

if [ ! -f "$APP_DIR/composer.json" ]; then
    echo "ERROR: composer.json not found."
    exit 1
fi

if [ ! -f "$APP_DIR/sql/schema.sql" ]; then
    echo "ERROR: sql/schema.sql not found."
    exit 1
fi

echo "Application files verified."

# =========================================================
# Install PHP dependencies
# =========================================================

echo "Installing Composer dependencies..."

composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader

# =========================================================
# Create native EC2 environment
#
# IMPORTANT:
# This is created ONLY on this EC2 instance.
# It does NOT modify the repository .env.
# =========================================================

echo "Creating native EC2 environment..."

cat > "$APP_DIR/.env" <<EOF
AWS_REGION=${aws_region}

RDS_HOST=${rds_host}
RDS_PORT=${rds_port}
RDS_DB_NAME=${db_name}
RDS_USER=${db_username}
RDS_PASSWORD=${db_password}

DYNAMODB_USERS_TABLE=${dynamodb_table}
DYNAMODB_ENDPOINT=
EOF

chmod 640 "$APP_DIR/.env"

echo "Native EC2 .env created."

# =========================================================
# Wait for RDS
# =========================================================

echo "================================================="
echo "Waiting for RDS..."
echo "Host: $RDS_HOST"
echo "Port: $RDS_PORT"
echo "================================================="

MAX_ATTEMPTS=60
ATTEMPT=1

while true; do

    if mysql \
        -h "$RDS_HOST" \
        -P "$RDS_PORT" \
        -u "$DB_USER" \
        -p"$DB_PASSWORD" \
        "$DB_NAME" \
        -e "SELECT 1;" >/dev/null 2>&1
    then
        echo "RDS connection successful."
        break
    fi

    if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
        echo "ERROR: RDS did not become available."
        exit 1
    fi

    echo "RDS not ready. Attempt $ATTEMPT/$MAX_ATTEMPTS."
    echo "Waiting 10 seconds..."

    sleep 10

    ATTEMPT=$((ATTEMPT + 1))

done

# =========================================================
# Initialize database schema automatically
# =========================================================

echo "================================================="
echo "Checking CloudCart database schema"
echo "================================================="

PRODUCTS_TABLE=$(mysql \
    -h "$RDS_HOST" \
    -P "$RDS_PORT" \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    "$DB_NAME" \
    -Nse \
    "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB_NAME' AND table_name='products';")

if [ "$PRODUCTS_TABLE" = "0" ]; then

    echo "Products table does not exist."
    echo "Initializing database from schema.sql..."

    mysql \
        -h "$RDS_HOST" \
        -P "$RDS_PORT" \
        -u "$DB_USER" \
        -p"$DB_PASSWORD" \
        "$DB_NAME" < "$APP_DIR/sql/schema.sql"

    echo "Database schema initialized successfully."

else

    echo "Products table already exists."
    echo "Skipping database initialization."

fi

# =========================================================
# Verify database
# =========================================================

echo "================================================="
echo "Database tables"
echo "================================================="

mysql \
    -h "$RDS_HOST" \
    -P "$RDS_PORT" \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    "$DB_NAME" \
    -e "SHOW TABLES;"

# =========================================================
# Configure Apache
# =========================================================

echo "Configuring Apache..."

cat > /etc/apache2/sites-available/cloudcart.conf <<EOF
<VirtualHost *:80>

    ServerName _

    DocumentRoot $${APP_DIR}

    <Directory $${APP_DIR}>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    DirectoryIndex index.html index.php

    ErrorLog \$${APACHE_LOG_DIR}/cloudcart-error.log
    CustomLog \$${APACHE_LOG_DIR}/cloudcart-access.log combined

</VirtualHost>
EOF

# =========================================================
# Enable Apache modules/site
# =========================================================

a2enmod rewrite
a2enmod php8.3 || true

a2dissite 000-default.conf || true
a2ensite cloudcart.conf

# =========================================================
# Validate Apache configuration
# =========================================================

apache2ctl configtest

# =========================================================
# Application permissions
# =========================================================

chown -R www-data:www-data "$APP_DIR"

find "$APP_DIR" -type d -exec chmod 755 {} \;
find "$APP_DIR" -type f -exec chmod 644 {} \;

chmod 640 "$APP_DIR/.env"

# =========================================================
# Restart Apache
# =========================================================

systemctl restart apache2

# =========================================================
# Final verification
# =========================================================

echo "================================================="
echo "CloudCart Native Deployment Verification"
echo "================================================="

echo "Apache:"
systemctl is-active apache2

echo ""
echo "PHP:"
php -v | head -n 1

echo ""
echo "Composer:"
composer --version

echo ""
echo "Application:"
ls -la "$APP_DIR"

echo ""
echo "Database:"
mysql \
    -h "$RDS_HOST" \
    -P "$RDS_PORT" \
    -u "$DB_USER" \
    -p"$DB_PASSWORD" \
    "$DB_NAME" \
    -e "SHOW TABLES;"

echo ""
echo "HTTP:"
curl -I http://localhost/ || true

echo ""
echo "================================================="
echo "CloudCart Native PHP Deployment COMPLETE"
echo "Completed: $(date)"
echo "================================================="
