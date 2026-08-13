# ☁️ CloudCart — AWS E-Commerce Cloud Platform

<p align="center">

![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?logo=php&logoColor=white)
![Apache](https://img.shields.io/badge/Apache-D22128?logo=apache&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)
![Amazon RDS](https://img.shields.io/badge/Amazon%20RDS-527FFF?logo=amazonrds&logoColor=white)
![DynamoDB](https://img.shields.io/badge/DynamoDB-4053D6?logo=amazondynamodb&logoColor=white)
![EC2](https://img.shields.io/badge/Amazon%20EC2-FF9900?logo=amazonec2&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-E95420?logo=linux&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-121011?logo=gnubash&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

</p>

<p align="center">

<strong>AWS E-Commerce Platform with Two Deployment Options: Docker or Native PHP</strong>

</p>

<p align="center">

Terraform • AWS EC2 • Docker • PHP • Apache • Amazon RDS • MySQL • DynamoDB • Linux • AWS CLI

</p>

---

# 🚀 Project Highlights

- ☁️ AWS-based PHP E-Commerce Application
- 🐳 Run the application using Docker
- 🖥️ Run the application using Native PHP + Apache
- 🔀 Two independent application deployment approaches
- 🏗️ Infrastructure as Code using Terraform
- 🐬 Amazon RDS MySQL for relational application data
- ⚡ Amazon DynamoDB for NoSQL user data
- 🌐 AWS EC2 application hosting
- 🔐 AWS Security Groups and IAM integration
- 🐧 Ubuntu Linux server deployment
- 📦 Composer-based PHP dependencies
- 🔄 Reproducible infrastructure
- 🧩 Separation of application and database layers
- 🛠️ Traditional and containerized deployment demonstrated in one project

---

# 📌 Project Status

| Property | Value |
|----------|-------|
| Version | v1.0 |
| Status | Production Ready Demo |
| Application | CloudCart E-Commerce |
| Language | PHP |
| Web Server | Apache |
| Cloud Provider | AWS |
| Compute | Amazon EC2 |
| Relational Database | Amazon RDS MySQL |
| NoSQL Database | Amazon DynamoDB |
| Infrastructure as Code | Terraform |
| Containerization | Docker |
| Operating System | Ubuntu Linux |
| Deployment Options | Docker / Native PHP |
| License | MIT |

---

# 📚 Table of Contents

- [📖 Executive Summary](#-executive-summary)
- [🎯 Project Goals](#-project-goals)
- [📦 What This Project Demonstrates](#-what-this-project-demonstrates)
- [✨ Key Features](#-key-features)
- [🚀 Two Ways to Run CloudCart](#-two-ways-to-run-cloudcart)
- [🏛️ High-Level Architecture](#️-high-level-architecture)
- [🔄 Application Data Flow](#-application-data-flow)
- [🐳 Option 1 — Docker Deployment](#-option-1--docker-deployment)
- [🖥️ Option 2 — Native PHP Deployment](#️-option-2--native-php-deployment)
- [🗄️ AWS Data Layer](#️-aws-data-layer)
- [🐬 Amazon RDS MySQL](#-amazon-rds-mysql)
- [⚡ Amazon DynamoDB](#-amazon-dynamodb)
- [🏗️ Infrastructure as Code](#️-infrastructure-as-code)
- [🛠️ Technology Stack](#️-technology-stack)
- [📂 Repository Structure](#-repository-structure)
- [🎯 Design Principles](#-design-principles)
- [📋 Prerequisites](#-prerequisites)
- [☁️ AWS Prerequisites](#️-aws-prerequisites)
- [🔑 AWS CLI Configuration](#-aws-cli-configuration)
- [🚀 Deployment — Choose Your Method](#-deployment--choose-your-method)
- [🐳 Docker Deployment](#-docker-deployment)
- [🖥️ Native PHP Deployment](#️-native-php-deployment)
- [🗃️ Database Configuration](#️-database-configuration)
- [🔐 IAM and AWS Permissions](#-iam-and-aws-permissions)
- [🌐 Network Architecture](#-network-architecture)
- [🔒 Security Considerations](#-security-considerations)
- [🧪 Application Validation](#-application-validation)
- [📊 Infrastructure Validation](#-infrastructure-validation)
- [🛑 Troubleshooting](#-troubleshooting)
- [🧹 Cleanup](#-cleanup)
- [📈 Future Improvements](#-future-improvements)
- [🎓 DevOps and Cloud Concepts Demonstrated](#-devops-and-cloud-concepts-demonstrated)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

# 📖 Executive Summary

**CloudCart** is an AWS-based e-commerce application designed to demonstrate practical Cloud Engineering, DevOps, Linux administration, Infrastructure as Code, containerization, and managed database architecture.

The most important feature of this project is that **the same CloudCart application can be run in two different ways**.

## The two deployment options are:

### 🐳 Option 1 — Docker

The application runs inside a Docker container containing the required Apache and PHP runtime.

```text
CloudCart Source Code
        │
        ▼
    Dockerfile
        │
        ▼
   Docker Image
        │
        ▼
 Docker Container
        │
        ▼
 Apache + PHP
        │
        ▼
    AWS EC2
```

### 🖥️ Option 2 — Native PHP

The application runs directly on an Ubuntu EC2 server using Apache and PHP installed on the host operating system.

```text
CloudCart Source Code
        │
        ▼
    Ubuntu EC2
        │
        ├── Apache
        ├── PHP
        └── CloudCart
```

Both deployment methods use the same AWS data layer:

```text
                    CloudCart
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
        Amazon RDS             DynamoDB
          MySQL               User Data
             │                     │
             ▼                     ▼
      Products / Orders          Users
```

This means the project demonstrates how **one application can use two different compute/deployment models while using AWS-managed database services as the backend data layer**.

---

# 🎯 Project Goals

The primary goals of CloudCart are:

- Build a functional PHP e-commerce application
- Demonstrate two different ways to deploy the same application
- Provide a Docker-based deployment option
- Provide a Native PHP deployment option
- Host the application on AWS EC2
- Provision infrastructure using Terraform
- Use Amazon RDS for relational application data
- Use Amazon DynamoDB for NoSQL user data
- Demonstrate AWS networking
- Demonstrate AWS Security Groups
- Demonstrate IAM-based AWS service access
- Demonstrate Linux server administration
- Demonstrate containerized application architecture
- Demonstrate traditional PHP server architecture
- Separate compute from the database layer
- Build a reproducible cloud deployment workflow

---

# 📦 What This Project Demonstrates

CloudCart combines several real-world Cloud and DevOps concepts.

## Application

The PHP application provides functionality for:

- Products
- Product categories
- Product prices
- Product stock
- Product CRUD operations
- Users
- User details
- User CRUD operations
- Orders
- Relational database operations
- NoSQL database operations

---

## AWS

The project uses:

- Amazon EC2
- Amazon RDS
- Amazon DynamoDB
- Amazon VPC
- Security Groups
- IAM
- AWS CLI

---

## Deployment

The application can be deployed using either:

```text
┌──────────────────────────────────────┐
│        Choose One Deployment         │
├──────────────────────────────────────┤
│                                      │
│  🐳 Docker                           │
│                                      │
│  OR                                  │
│                                      │
│  🖥️ Native PHP + Apache              │
│                                      │
└──────────────────────────────────────┘
```

You do **not** need to use both methods at the same time.

The user can choose the deployment model based on their requirements.

---

# 🚀 Two Ways to Run CloudCart

CloudCart intentionally provides **two deployment options**.

```text
                         CloudCart
                            │
              ┌─────────────┴─────────────┐
              │                           │
              ▼                           ▼
       🐳 OPTION 1                  🖥️ OPTION 2
       Docker                       Native PHP
              │                           │
              ▼                           ▼
       Docker Container             Apache + PHP
              │                           │
              ▼                           ▼
           AWS EC2                    AWS EC2
              │                           │
              └─────────────┬─────────────┘
                            │
                            ▼
                    AWS Data Layer
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
             Amazon RDS            DynamoDB
               MySQL              User Details
                 │
                 ▼
          Products / Orders
```

---

# 🐳 Option 1 — Docker Deployment

The Docker option is designed for users who want to run CloudCart as a containerized application.

The application and its runtime environment are packaged into a Docker image.

```text
Developer
    │
    ▼
CloudCart Repository
    │
    ▼
Dockerfile
    │
    ▼
docker build
    │
    ▼
Docker Image
    │
    ▼
Docker Container
    │
    ├── Apache
    ├── PHP
    └── CloudCart
            │
            ├──────────────► Amazon RDS
            │
            └──────────────► DynamoDB
```

---

# 🖥️ Option 2 — Native PHP Deployment

The Native PHP option is designed for users who want to run CloudCart directly on an Ubuntu server without Docker.

```text
Developer
    │
    ▼
CloudCart Repository
    │
    ▼
Ubuntu EC2
    │
    ├── Apache
    ├── PHP
    ├── Composer
    └── CloudCart
            │
            ├──────────────► Amazon RDS
            │
            └──────────────► DynamoDB
```

---

# 🆚 Docker vs Native PHP

| Feature | 🐳 Docker | 🖥️ Native PHP |
|---------|-----------|---------------|
| Deployment | Containerized | Traditional |
| Runtime | Docker Container | Host OS |
| Web Server | Apache in container | Apache on EC2 |
| PHP | Containerized | Host-installed |
| Isolation | High | Lower |
| Portability | High | Medium |
| Server Dependency | Docker | Linux packages |
| Application Packaging | Docker Image | Source Code |
| Infrastructure | Terraform | Terraform |
| Compute | AWS EC2 | AWS EC2 |
| Database | RDS + DynamoDB | RDS + DynamoDB |
| Best For | Portable deployments | Traditional server deployment |

---

# 🏛️ High-Level Architecture

```text
                                  CloudCart
                                      │
                     ┌────────────────┴────────────────┐
                     │                                 │
                     ▼                                 ▼
              🐳 Docker Option                  🖥️ Native PHP Option
                     │                                 │
                     ▼                                 ▼
              Docker Container                  Apache + PHP
                     │                                 │
                     ▼                                 ▼
                  AWS EC2                         AWS EC2
                     │                                 │
                     └────────────────┬────────────────┘
                                      │
                              Shared AWS Data Layer
                                      │
                         ┌────────────┴────────────┐
                         │                         │
                         ▼                         ▼
                   Amazon RDS                 DynamoDB
                     MySQL                   NoSQL Users
                         │
                  ┌──────┴──────┐
                  │             │
                  ▼             ▼
              Products        Orders
```

---

# 🔄 Application Data Flow

CloudCart uses different storage technologies depending on the type of data.

## Product Request

```text
Browser
   │
   ▼
CloudCart
   │
   ▼
api/products.php
   │
   ▼
MySQL Connection
   │
   ▼
Amazon RDS MySQL
   │
   ▼
Products Table
```

---

## User Request

```text
Browser
   │
   ▼
CloudCart
   │
   ▼
api/users.php
   │
   ▼
AWS DynamoDB API
   │
   ▼
Amazon DynamoDB
   │
   ▼
Users Table
```

---

# 🗄️ AWS Data Layer

The application compute layer is separated from the data layer.

```text
             Application Compute
                    │
        ┌───────────┴───────────┐
        │                       │
        ▼                       ▼
     Docker                Native PHP
        │                       │
        └───────────┬───────────┘
                    │
                    ▼
              AWS Data Layer
                    │
          ┌─────────┴─────────┐
          │                   │
          ▼                   ▼
       Amazon RDS         DynamoDB
        MySQL             NoSQL
          │                   │
          ▼                   ▼
 Products / Orders          Users
```

This architecture allows the application deployment method to change without changing the underlying data architecture.

---

# 🐬 Amazon RDS MySQL

Amazon RDS provides the relational database layer.

RDS stores structured application data such as:

- Products
- Orders
- Product relationships
- Pricing
- Stock quantities
- Categories

---

## RDS Example

```text
RDS Instance
     │
     ▼
cloud_cart_project
     │
     ├── products
     │
     └── orders
```

---

# 🗃️ Products Table

Example structure:

```text
products
├── id
├── name
├── description
├── price
├── stock_qty
├── category
├── created_at
└── updated_at
```

---

# 🧾 Orders Table

Example structure:

```text
orders
├── id
├── user_id
├── product_id
├── quantity
├── total_price
├── status
└── created_at
```

---

# ⚡ Amazon DynamoDB

DynamoDB provides the NoSQL user data layer.

Example table:

```text
Cloud_Users
```

User information can contain:

```text
user_id
name
email
phone
city
```

---

# 🆚 RDS vs DynamoDB

| Data | Storage | Reason |
|------|---------|--------|
| Products | Amazon RDS MySQL | Structured relational data |
| Orders | Amazon RDS MySQL | Relational and transactional |
| Product relationships | Amazon RDS MySQL | Foreign keys |
| User details | DynamoDB | Flexible NoSQL data |
| User profiles | DynamoDB | Key-value/document model |

---

# 🏗️ Infrastructure as Code

CloudCart uses Terraform to provision the AWS infrastructure.

The repository contains separate Terraform configurations for the two deployment models.

```text
terraform/
    │
    └── Docker deployment infrastructure

terraform-native/
    │
    └── Native PHP deployment infrastructure
```

The application itself remains the same.

The difference is the way the application is executed.

---

# 🐳 Docker Infrastructure

The Docker deployment uses:

```text
terraform/
```

Terraform provisions the infrastructure required for the Docker-based application.

Typical architecture:

```text
AWS
│
├── VPC
├── Subnet
├── Internet Gateway
├── Route Table
├── Security Group
└── EC2
      │
      └── Docker
            │
            └── CloudCart
```

---

# 🖥️ Native PHP Infrastructure

The Native PHP deployment uses:

```text
terraform-native/
```

Typical architecture:

```text
AWS
│
├── VPC
├── Subnet
├── Internet Gateway
├── Route Table
├── Security Group
└── EC2
      │
      ├── Apache
      ├── PHP
      └── CloudCart
```

---

# ⚙️ Terraform Workflow

The infrastructure follows the standard Terraform lifecycle:

```text
Terraform Configuration
        │
        ▼
terraform init
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
AWS Infrastructure
```

---

# 🛠️ Technology Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| Cloud | AWS | Cloud Infrastructure |
| Compute | Amazon EC2 | Application Hosting |
| IaC | Terraform | Infrastructure Provisioning |
| Application | PHP | Application Runtime |
| Web Server | Apache | HTTP Server |
| Containerization | Docker | Containerized Deployment |
| Relational Database | Amazon RDS | Managed MySQL |
| Database | MySQL | Products and Orders |
| NoSQL Database | DynamoDB | User Data |
| Operating System | Ubuntu Linux | EC2 Server |
| CLI | AWS CLI | AWS Management |
| Automation | Bash | Deployment Automation |
| Dependencies | Composer | PHP Package Management |
| Version Control | Git | Source Code Management |

---

# 📂 Repository Structure

```text
kucl-mini-project/
│
├── api/
│   ├── products.php
│   └── users.php
│
├── config/
│   └── application configuration
│
├── models/
│   └── application models
│
├── sql/
│   └── database schema
│
├── vendor/
│   └── Composer dependencies
│
├── terraform/
│   └── Docker deployment infrastructure
│
├── terraform-native/
│   └── Native PHP deployment infrastructure
│
├── Dockerfile
│
├── composer.json
│
├── composer.lock
│
├── index.html
│
├── README.md
│
└── .gitignore
```

---

# 🎯 Design Principles

CloudCart follows these principles:

- Infrastructure as Code
- Two deployment options
- Separation of compute and data
- Managed database services
- Containerized application option
- Traditional application option
- Reproducible infrastructure
- AWS-native services
- Linux-based deployment
- Version-controlled infrastructure
- Secure database connectivity
- Modular architecture

---

# 📋 Prerequisites

Before running CloudCart, install the required tools.

| Tool | Docker Deployment | Native PHP Deployment |
|------|-------------------|-----------------------|
| Git | Required | Required |
| AWS CLI | Required | Required |
| Terraform | Required | Required |
| SSH | Required | Required |
| Docker | Required | Not Required |
| PHP | Not Required on host | Required |
| Composer | Not Required on host | Required |

---

# ☁️ AWS Prerequisites

You need:

- AWS Account
- AWS CLI
- AWS credentials
- EC2 key pair
- Appropriate IAM permissions
- AWS region

Verify AWS access:

```bash
aws sts get-caller-identity
```

---

# 🔑 AWS CLI Configuration

Configure AWS:

```bash
aws configure
```

Example:

```text
AWS Access Key ID:     ********
AWS Secret Access Key: ********
Default region name:  us-east-1
Default output format: json
```

Verify:

```bash
aws sts get-caller-identity
```

---

# 🔐 EC2 Key Pair

Create an EC2 key pair in AWS.

Example:

```text
cloudcart-key
```

Set private key permissions:

```bash
chmod 400 cloudcart-key.pem
```

---

# 🚀 Deployment — Choose Your Method

After cloning the project, **choose one of the following two deployment methods**.

```text
                 Clone CloudCart
                       │
                       ▼
              Choose deployment
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
     🐳 Docker                 🖥️ Native PHP
          │                         │
          ▼                         ▼
      terraform/             terraform-native/
          │                         │
          ▼                         ▼
        AWS EC2                  AWS EC2
          │                         │
          └────────────┬────────────┘
                       │
                       ▼
                  CloudCart
```

You can use either:

```text
Option 1 → Docker
```

or:

```text
Option 2 → Native PHP
```

**You do not need to deploy both options.**

---

# 📥 Clone the Repository

```bash
git clone https://github.com/vijayvw/kucl-mini-project.git
```

Enter the project:

```bash
cd kucl-mini-project
```

---

# 🐳 Docker Deployment

## Step 1 — Enter Docker Terraform Directory

```bash
cd terraform
```

---

## Step 2 — Initialize Terraform

```bash
terraform init
```

---

## Step 3 — Validate Terraform

```bash
terraform validate
```

---

## Step 4 — Review Infrastructure

```bash
terraform plan
```

---

## Step 5 — Create Infrastructure

```bash
terraform apply
```

Confirm:

```text
yes
```

Terraform provisions the infrastructure required for the Docker deployment.

---

## Step 6 — Get EC2 IP

```bash
terraform output
```

Copy the EC2 public IP.

---

## Step 7 — Connect to EC2

```bash
ssh -i ../cloudcart-key.pem ubuntu@<EC2_PUBLIC_IP>
```

---

## Step 8 — Verify Docker

```bash
docker --version
```

If Docker is not installed:

```bash
sudo apt update
```

```bash
sudo apt install docker.io -y
```

Start Docker:

```bash
sudo systemctl enable --now docker
```

---

## Step 9 — Build CloudCart Image

From the CloudCart project directory:

```bash
docker build -t cloudcart .
```

Verify:

```bash
docker images
```

---

## Step 10 — Run CloudCart

```bash
docker run -d \
  --name cloudcart \
  -p 80:80 \
  cloudcart
```

Verify:

```bash
docker ps
```

---

## Step 11 — Check Logs

```bash
docker logs cloudcart
```

---

## Step 12 — Test Application

```bash
curl http://localhost
```

From your computer:

```bash
curl http://<EC2_PUBLIC_IP>
```

Open:

```text
http://<EC2_PUBLIC_IP>
```

---

# 🖥️ Native PHP Deployment

If you do not want to use Docker, use the Native PHP deployment.

---

## Step 1 — Enter Native Terraform Directory

From the project root:

```bash
cd terraform-native
```

---

## Step 2 — Initialize Terraform

```bash
terraform init
```

---

## Step 3 — Validate

```bash
terraform validate
```

---

## Step 4 — Review Plan

```bash
terraform plan
```

---

## Step 5 — Create Infrastructure

```bash
terraform apply
```

Confirm:

```text
yes
```

---

## Step 6 — Get EC2 IP

```bash
terraform output
```

---

## Step 7 — SSH Into EC2

```bash
ssh -i ../cloudcart-key.pem ubuntu@<EC2_PUBLIC_IP>
```

---

## Step 8 — Update Ubuntu

```bash
sudo apt update
```

```bash
sudo apt upgrade -y
```

---

## Step 9 — Install Apache

```bash
sudo apt install apache2 -y
```

Enable Apache:

```bash
sudo systemctl enable --now apache2
```

Verify:

```bash
sudo systemctl status apache2
```

---

## Step 10 — Install PHP

```bash
sudo apt install \
  php \
  php-mysql \
  php-curl \
  php-json \
  php-mbstring \
  php-xml \
  php-zip \
  php-cli \
  unzip \
  -y
```

Verify:

```bash
php -v
```

---

## Step 11 — Install Git

```bash
sudo apt install git -y
```

---

## Step 12 — Install Composer

If Composer is required:

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
```

```bash
php composer-setup.php
```

```bash
sudo mv composer.phar /usr/local/bin/composer
```

Verify:

```bash
composer --version
```

---

## Step 13 — Clone CloudCart

```bash
cd /var/www
```

```bash
sudo git clone https://github.com/vijayvw/kucl-mini-project.git cloudcart
```

---

## Step 14 — Set Permissions

```bash
sudo chown -R www-data:www-data /var/www/cloudcart
```

---

## Step 15 — Configure Apache

Create the VirtualHost:

```bash
sudo nano /etc/apache2/sites-available/cloudcart.conf
```

Use:

```apache
<VirtualHost *:80>

    ServerName cloudcart

    DocumentRoot /var/www/cloudcart

    <Directory /var/www/cloudcart>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/cloudcart-error.log
    CustomLog ${APACHE_LOG_DIR}/cloudcart-access.log combined

</VirtualHost>
```

Enable the site:

```bash
sudo a2ensite cloudcart.conf
```

Enable rewrite:

```bash
sudo a2enmod rewrite
```

Check Apache configuration:

```bash
sudo apache2ctl configtest
```

Expected:

```text
Syntax OK
```

Restart:

```bash
sudo systemctl restart apache2
```

---

## Step 16 — Test Native PHP Application

```bash
curl http://localhost
```

From your computer:

```bash
curl http://<EC2_PUBLIC_IP>
```

Open:

```text
http://<EC2_PUBLIC_IP>
```

---

# 🗃️ Database Configuration

The application requires connection details for:

```text
Amazon RDS MySQL
```

and:

```text
Amazon DynamoDB
```

Example environment configuration:

```text
AWS_REGION=us-east-1

RDS_HOST=<RDS_ENDPOINT>
RDS_PORT=3306
DB_NAME=cloud_cart_project
DB_USER=<DB_USERNAME>
DB_PASSWORD=<DB_PASSWORD>

DYNAMODB_TABLE=Cloud_Users
```

Do not commit real credentials into Git.

---

# 🐬 RDS Connectivity

Check the RDS endpoint:

```bash
aws rds describe-db-instances \
  --region us-east-1 \
  --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,Endpoint.Address,Endpoint.Port,DBName]' \
  --output table
```

Test DNS:

```bash
nslookup <RDS_ENDPOINT>
```

Test port:

```bash
nc -vz <RDS_ENDPOINT> 3306
```

Expected:

```text
Connection to <RDS_ENDPOINT> 3306 port [tcp/mysql] succeeded!
```

---

# ⚡ DynamoDB Connectivity

List tables:

```bash
aws dynamodb list-tables \
  --region us-east-1 \
  --output table
```

Describe the table:

```bash
aws dynamodb describe-table \
  --region us-east-1 \
  --table-name <TABLE_NAME>
```

---

# 🔐 IAM and AWS Permissions

The AWS identity used to create infrastructure needs permissions for the resources being provisioned.

Typical infrastructure permissions include:

```text
EC2
VPC
Security Groups
RDS
DynamoDB
IAM
```

The application runtime should use only the permissions it requires.

For DynamoDB, typical application permissions may include:

```text
GetItem
PutItem
UpdateItem
DeleteItem
Query
Scan
```

Avoid using unrestricted administrator permissions for the application in production.

---

# 🌐 Network Architecture

```text
                         Internet
                            │
                            ▼
                    AWS Internet Gateway
                            │
                            ▼
                      Public Subnet
                            │
                            ▼
                       AWS EC2
                            │
               ┌────────────┴────────────┐
               │                         │
               ▼                         ▼
        CloudCart Application       AWS Services
               │                         │
               │                ┌────────┴────────┐
               │                │                 │
               ▼                ▼                 ▼
          RDS MySQL         DynamoDB           IAM
               │
               ▼
          Private Data
```

---

# 🔒 Security Considerations

## RDS

Do not expose MySQL publicly unless there is a specific requirement.

Recommended:

```text
EC2 Security Group
       │
       │ TCP 3306
       ▼
RDS Security Group
       │
       ▼
RDS MySQL
```

---

## SSH

Restrict SSH access to your trusted public IP.

Avoid:

```text
0.0.0.0/0
```

Prefer:

```text
YOUR_PUBLIC_IP/32
```

---

## Credentials

Never commit:

```text
AWS Access Keys
AWS Secret Keys
RDS Passwords
Private Keys
.env files
Terraform secret variables
```

Use:

- IAM Roles
- AWS Secrets Manager
- Environment variables
- Secure CI/CD secrets

for production deployments.

---

# 🧪 Application Validation

## Check Application

```bash
curl -I http://<EC2_PUBLIC_IP>
```

Expected:

```text
HTTP/1.1 200 OK
```

---

# 📦 Product API

Get products:

```bash
curl http://<EC2_PUBLIC_IP>/api/products.php
```

Create product:

```bash
curl -X POST \
  http://<EC2_PUBLIC_IP>/api/products.php \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Wireless Mouse",
    "category": "Electronics",
    "price": 799,
    "stock_qty": 100
  }'
```

Update product:

```bash
curl -X PUT \
  "http://<EC2_PUBLIC_IP>/api/products.php?id=1" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Wireless Gaming Mouse",
    "category": "Electronics",
    "price": 1299,
    "stock_qty": 80
  }'
```

Delete product:

```bash
curl -X DELETE \
  "http://<EC2_PUBLIC_IP>/api/products.php?id=1"
```

---

# 👤 User API

Get users:

```bash
curl http://<EC2_PUBLIC_IP>/api/users.php
```

Create user:

```bash
curl -X POST \
  http://<EC2_PUBLIC_IP>/api/users.php \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Vijay",
    "email": "vijay@example.com",
    "phone": "9876543210",
    "city": "Mumbai"
  }'
```

Update user:

```bash
curl -X PUT \
  "http://<EC2_PUBLIC_IP>/api/users.php?user_id=<USER_ID>" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Vijay VW",
    "email": "vijay@example.com",
    "phone": "9876543210",
    "city": "Mumbai"
  }'
```

Delete user:

```bash
curl -X DELETE \
  "http://<EC2_PUBLIC_IP>/api/users.php?user_id=<USER_ID>"
```

---

# 📊 Infrastructure Validation

Check EC2:

```bash
aws ec2 describe-instances \
  --region us-east-1
```

Check RDS:

```bash
aws rds describe-db-instances \
  --region us-east-1
```

Check DynamoDB:

```bash
aws dynamodb list-tables \
  --region us-east-1
```

---

# 🛑 Troubleshooting

## Docker Container Not Running

```bash
docker ps -a
```

Check logs:

```bash
docker logs cloudcart
```

Restart:

```bash
docker restart cloudcart
```

---

## Apache Not Running

```bash
sudo systemctl status apache2
```

Restart:

```bash
sudo systemctl restart apache2
```

Check configuration:

```bash
sudo apache2ctl configtest
```

---

## PHP Not Working

Check PHP:

```bash
php -v
```

Check PHP modules:

```bash
php -m
```

Check Apache modules:

```bash
apache2ctl -M | grep php
```

---

## RDS Connection Failed

Verify:

```bash
nc -vz <RDS_ENDPOINT> 3306
```

Check:

- RDS status
- RDS endpoint
- Database name
- Username
- Password
- VPC
- Subnet
- Route tables
- Security Groups
- Port `3306`

---

## DynamoDB Access Denied

Check AWS identity:

```bash
aws sts get-caller-identity
```

Try:

```bash
aws dynamodb list-tables \
  --region us-east-1
```

If you receive:

```text
AccessDeniedException
```

verify the IAM permissions.

---

## Application Returns HTTP 500

For Native PHP:

```bash
sudo tail -f /var/log/apache2/error.log
```

CloudCart-specific log:

```bash
sudo tail -f /var/log/apache2/cloudcart-error.log
```

For Docker:

```bash
docker logs cloudcart
```

---

# 🧹 Cleanup

Destroy only the infrastructure for the deployment method you used.

## Docker Deployment

```bash
cd terraform
```

Review:

```bash
terraform plan -destroy
```

Destroy:

```bash
terraform destroy
```

---

## Native PHP Deployment

```bash
cd terraform-native
```

Review:

```bash
terraform plan -destroy
```

Destroy:

```bash
terraform destroy
```

---

# ⚠️ Database Cleanup Warning

Before destroying infrastructure, verify whether the RDS and DynamoDB resources contain data that you need.

Potential resources that may be deleted include:

```text
EC2
RDS
DynamoDB
VPC
Subnets
Security Groups
Internet Gateway
Route Tables
```

Always back up important data before destructive operations.

---

# 📈 Future Improvements

Possible future improvements include:

- Application Load Balancer
- Auto Scaling Groups
- HTTPS using AWS Certificate Manager
- Route 53 DNS
- CloudFront
- AWS WAF
- AWS Secrets Manager
- Systems Manager Parameter Store
- CloudWatch Logs
- CloudWatch Metrics
- RDS Multi-AZ
- RDS automated backups
- CI/CD using GitHub Actions
- Docker image publishing
- Amazon ECS deployment
- Amazon EKS deployment
- Kubernetes deployment
- Blue/Green deployments
- Canary deployments
- Centralized logging
- Application monitoring

---

# 🔄 Possible CI/CD Architecture

A future CI/CD pipeline could follow:

```text
Developer
    │
    ▼
Git Push
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├───────────────┐
    │               │
    ▼               ▼
PHP Tests       Docker Build
                    │
                    ▼
               Docker Registry
                    │
                    ▼
                AWS Deploy
                    │
                    ▼
                 AWS EC2
                    │
                    ▼
                CloudCart
```

---

# 🎓 DevOps and Cloud Concepts Demonstrated

## ☁️ Cloud Engineering

- AWS EC2
- AWS VPC
- Security Groups
- Amazon RDS
- DynamoDB
- IAM
- AWS CLI
- Cloud networking

---

## 🏗️ Infrastructure as Code

- Terraform
- Terraform providers
- Terraform variables
- Terraform outputs
- Terraform state
- Terraform plan
- Terraform apply
- Terraform destroy

---

## 🐳 Containerization

- Dockerfile
- Docker image
- Docker container
- Port mapping
- Container lifecycle
- Container logs

---

## 🖥️ Linux Administration

- Ubuntu
- SSH
- Apache
- PHP
- systemd
- Linux packages
- File permissions
- Service management
- Network troubleshooting

---

## 🗄️ Database Engineering

### Amazon RDS

- MySQL
- SQL
- Relational tables
- Foreign keys
- Products
- Orders

### DynamoDB

- NoSQL
- Partition keys
- User records
- AWS API
- IAM-based access

---

# 🧠 Why Two Deployment Options?

The main purpose of CloudCart is to demonstrate that the same application can be deployed using different application runtime models.

## Docker

Docker packages the application and runtime together.

```text
CloudCart
   │
   ▼
Docker Image
   │
   ▼
Container
   │
   ├── Apache
   ├── PHP
   └── Dependencies
```

This provides:

- Portability
- Isolation
- Consistent runtime
- Easier application packaging

---

## Native PHP

Native PHP installs the runtime directly on the server.

```text
Ubuntu EC2
   │
   ├── Apache
   ├── PHP
   ├── Dependencies
   └── CloudCart
```

This demonstrates:

- Traditional server administration
- Linux package management
- Apache configuration
- PHP configuration
- Direct host-based deployment

---

# 🆚 Final Comparison

| Area | 🐳 Docker | 🖥️ Native PHP |
|------|-----------|---------------|
| Application | Same CloudCart | Same CloudCart |
| AWS Compute | EC2 | EC2 |
| Web Server | Apache | Apache |
| PHP | Container | Host |
| Packaging | Docker Image | Source Code |
| Runtime Isolation | Yes | No container isolation |
| Deployment Style | Modern Containerized | Traditional Server |
| Terraform | Yes | Yes |
| RDS | Yes | Yes |
| DynamoDB | Yes | Yes |
| Linux | Yes | Yes |
| Best Demonstrates | Containerization | Server Administration |

---

# 📋 Complete Deployment Checklist

## Common

- [ ] AWS account available
- [ ] AWS CLI configured
- [ ] IAM permissions configured
- [ ] EC2 key pair created
- [ ] Repository cloned
- [ ] RDS available
- [ ] DynamoDB table available

---

## 🐳 If Using Docker

- [ ] Enter `terraform/`
- [ ] Run `terraform init`
- [ ] Run `terraform validate`
- [ ] Run `terraform plan`
- [ ] Run `terraform apply`
- [ ] Connect to EC2
- [ ] Install/verify Docker
- [ ] Build Docker image
- [ ] Start container
- [ ] Verify application
- [ ] Verify RDS connection
- [ ] Verify DynamoDB access

---

## 🖥️ If Using Native PHP

- [ ] Enter `terraform-native/`
- [ ] Run `terraform init`
- [ ] Run `terraform validate`
- [ ] Run `terraform plan`
- [ ] Run `terraform apply`
- [ ] Connect to EC2
- [ ] Install Apache
- [ ] Install PHP
- [ ] Install Composer
- [ ] Clone application
- [ ] Configure Apache
- [ ] Start Apache
- [ ] Verify application
- [ ] Verify RDS connection
- [ ] Verify DynamoDB access

---

# 🏁 Final Architecture

CloudCart provides a single PHP e-commerce application with **two different ways to run it**.

```text
                              CLOUDCART
                                  │
                  ┌───────────────┴───────────────┐
                  │                               │
                  ▼                               ▼
          🐳 OPTION 1                       🖥️ OPTION 2
          DOCKER                            NATIVE PHP
                  │                               │
                  ▼                               ▼
          Docker Container                  Apache + PHP
                  │                               │
                  ▼                               ▼
               AWS EC2                         AWS EC2
                  │                               │
                  └───────────────┬───────────────┘
                                  │
                                  ▼
                           AWS Data Layer
                                  │
                     ┌────────────┴────────────┐
                     │                         │
                     ▼                         ▼
                Amazon RDS                 DynamoDB
                  MySQL                   NoSQL Users
                     │
                ┌────┴────┐
                │         │
                ▼         ▼
             Products   Orders
```

---

# 🎉 CloudCart Is Ready

CloudCart demonstrates a complete AWS application deployment architecture while giving the user a choice between **two deployment methods**.

## 🐳 Choose Docker if you want:

- Containerized deployment
- Portable application runtime
- Application isolation
- Consistent dependencies
- Docker-based deployment experience

## 🖥️ Choose Native PHP if you want:

- Traditional PHP deployment
- Direct Apache configuration
- Linux server administration
- Host-based PHP runtime
- Traditional application deployment experience

Both approaches use:

```text
AWS EC2
   │
   ├── Amazon RDS MySQL
   │
   └── Amazon DynamoDB
```

The application remains the same; **only the deployment method changes**.

---

# 🤝 Contributing

Contributions are welcome.

1. Fork the repository.
2. Create a feature branch.

```bash
git checkout -b feature/my-feature
```

3. Make your changes.
4. Commit your changes.

```bash
git add .
git commit -m "Add new feature"
```

5. Push your branch.

```bash
git push origin feature/my-feature
```

6. Open a Pull Request.

---

# 📄 License

This project is licensed under the MIT License.

See the `LICENSE` file for more information.

---

<p align="center">

<strong>CloudCart — AWS E-Commerce Cloud Platform</strong>

</p>

<p align="center">

🐳 Docker Deployment &nbsp;•&nbsp; 🖥️ Native PHP Deployment

</p>

<p align="center">

☁️ AWS • 🏗️ Terraform • 🐘 PHP • 🐳 Docker • 🐬 MySQL • ⚡ DynamoDB

</p>

<p align="center">

Made with ❤️ by <strong>Vijay VW</strong>

</p>
