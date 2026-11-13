
-- =========================================
-- Retail Sales Analysis
-- Data Quality Checks
-- =========================================


-- SECTION 1: Total Number of Records

SELECT COUNT(*) AS total_rows
FROM orders;


-- SECTION 2: Check Missing Values

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date
FROM orders;


-- SECTION 3: Check Duplicate Row IDs

SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY row_id
HAVING COUNT(*) > 1;


-- SECTION 4: Check Invalid Sales and Profit Values

SELECT *
FROM orders
WHERE sales < 0 OR profit IS NULL;


-- SECTION 5: Check Date Consistency

SELECT *
FROM orders
WHERE ship_date < order_date;

-- SECTION 6: Check Loss-Making Orders

SELECT
    COUNT(*) AS loss_making_rows,
    ROUND(SUM(profit), 2) AS total_loss,
    ROUND(AVG(profit), 2) AS average_loss
FROM orders
WHERE profit < 0;