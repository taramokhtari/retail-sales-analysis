
-- =========================================
-- Retail Sales Analysis
-- Database: retail_sales
-- Dataset: Superstore
-- =========================================


-- SECTION 1: Create Orders Table

CREATE TABLE orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales NUMERIC(12,4),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(12,4),
    order_month VARCHAR(20)
);


-- SECTION 2: Verify Imported Data

SELECT COUNT(*) AS total_rows
FROM orders;


-- SECTION 3: Preview Data

SELECT *
FROM orders
LIMIT 5;
