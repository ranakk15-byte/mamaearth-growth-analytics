CREATE DATABASE mamaearth;
USE mamaearth;
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    acquisition_source VARCHAR(100)
);

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    discount_pct DECIMAL(5,2) DEFAULT 0,
    rating DECIMAL(3,2) NULL,
    order_date DATE NOT NULL,
    returned BOOLEAN DEFAULT FALSE,
    payment_method VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

USE mamaearth;

DROP TABLE IF EXISTS orders;