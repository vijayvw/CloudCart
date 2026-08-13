-- =========================================================
-- CloudCart - RDS MySQL Schema
-- Database is created by Terraform/RDS.
-- This file initializes the application tables and seed data.
-- =========================================================

-- Products catalog
CREATE TABLE IF NOT EXISTS products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)      NOT NULL,
    description TEXT              NULL,
    price       DECIMAL(10,2)     NOT NULL DEFAULT 0.00,
    stock_qty   INT               NOT NULL DEFAULT 0,
    category    VARCHAR(80)       NULL,
    created_at  TIMESTAMP         DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP         DEFAULT CURRENT_TIMESTAMP
                                  ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Orders
-- user_id maps to the user_id stored in DynamoDB.
CREATE TABLE IF NOT EXISTS orders (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     VARCHAR(64)       NOT NULL,
    product_id  INT               NOT NULL,
    quantity    INT               NOT NULL DEFAULT 1,
    total_price DECIMAL(10,2)     NOT NULL,
    status      ENUM(
                    'PENDING',
                    'CONFIRMED',
                    'SHIPPED',
                    'DELIVERED',
                    'CANCELLED'
                ) DEFAULT 'PENDING',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Seed data
-- These are inserted only when the database is initialized.
INSERT INTO products
    (name, description, price, stock_qty, category)
VALUES
    (
        'Wireless Mouse',
        'Ergonomic 2.4GHz wireless mouse',
        799.00,
        120,
        'Electronics'
    ),
    (
        'Cotton T-Shirt',
        'Unisex round-neck cotton t-shirt',
        499.00,
        300,
        'Apparel'
    ),
    (
        'Notebook Set',
        'Pack of 3 ruled notebooks',
        199.00,
        500,
        'Stationery'
    );
