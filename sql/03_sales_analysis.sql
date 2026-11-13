-- =========================================
-- Retail Sales Analysis
-- Sales and Profit Analysis
-- =========================================

-- SECTION 1: Sales and Profit by Category

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;
-- SECTION 2: Sales and Profit by Sub-Category

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders
GROUP BY sub_category
ORDER BY total_profit DESC;

-- SECTION 3: Profit Margin by Sub-Category

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY sub_category
ORDER BY profit_margin_percentage DESC;

-- SECTION 4: Impact of Discount on Sales and Profit

SELECT
    discount,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders
GROUP BY discount
ORDER BY discount;

-- SECTION 5: Profit Margin by Category and Discount

SELECT
    category,
    discount,
    COUNT(*) AS total_rows,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY category, discount
ORDER BY category, discount;

-- SECTION 6: Monthly Sales and Profit Analysis

SELECT
    EXTRACT(YEAR FROM order_date) AS sales_year,
    EXTRACT(MONTH FROM order_date) AS sales_month,
    TO_CHAR(order_date, 'Month') AS month_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'Month')
ORDER BY sales_year, sales_month;

-- SECTION 7: Seasonal Sales Analysis

SELECT
    EXTRACT(MONTH FROM order_date) AS month_number,
    TO_CHAR(order_date, 'FMMonth') AS month_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(AVG(sales), 2) AS average_row_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_row_profit
FROM orders
GROUP BY
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'FMMonth')
ORDER BY month_number;

-- SECTION 8: Year-over-Year Sales and Profit Growth

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::INT AS sales_year,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY EXTRACT(YEAR FROM order_date)
),

yearly_comparison AS (
    SELECT
        sales_year,
        total_sales,
        total_profit,
        total_orders,
        LAG(total_sales) OVER (ORDER BY sales_year) AS previous_year_sales,
        LAG(total_profit) OVER (ORDER BY sales_year) AS previous_year_profit,
        LAG(total_orders) OVER (ORDER BY sales_year) AS previous_year_orders
    FROM yearly_sales
)

SELECT
    sales_year,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(total_profit, 2) AS total_profit,
    total_orders,
    ROUND(
        (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0) * 100, 2
    ) AS sales_growth_percentage,
    ROUND(
        (total_profit - previous_year_profit)
        / NULLIF(ABS(previous_year_profit), 0) * 100, 2
    ) AS profit_growth_percentage,
    ROUND(
        (total_orders - previous_year_orders)::NUMERIC
        / NULLIF(previous_year_orders, 0) * 100, 2
    ) AS orders_growth_percentage
FROM yearly_comparison
ORDER BY sales_year;

-- SECTION 9: Top 10 Customers by Sales

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- SECTION 10: Top 10 Customers by Profit

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- SECTION 11: Sales and Profit by Region

SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- SECTION 12: Sales and Profit by State

SELECT
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY state
ORDER BY total_profit DESC;

-- SECTION 13: Sales and Profit by City

SELECT
    city,
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY city, state
ORDER BY total_profit DESC
LIMIT 20;

-- SECTION 14: Top 20 Loss-Making Cities

SELECT
    city,
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY city, state
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 20;

-- SECTION 15: Sales and Profit by Ship Mode

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(profit), 2) AS average_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- SECTION 16: Average Shipping Duration

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        AVG(ship_date - order_date),
        2
    ) AS average_shipping_days,
    MIN(ship_date - order_date) AS minimum_shipping_days,
    MAX(ship_date - order_date) AS maximum_shipping_days
FROM orders
GROUP BY ship_mode
ORDER BY average_shipping_days;


-- =========================================
-- SECTION 17: Average Order Value by Region
-- =========================================

SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    ROUND(
        SUM(profit) / COUNT(DISTINCT order_id),
        2
    ) AS average_profit_per_order
FROM orders
GROUP BY region
ORDER BY average_order_value DESC;


-- =========================================
-- SECTION 18: Customer Segment Analysis
-- =========================================

SELECT
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;


-- =========================================
-- SECTION 19: Top 10 Best-Selling Products
-- =========================================

SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================
-- SECTION 20: Top 10 Most Profitable Products
-- =========================================

SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_id, product_name
ORDER BY total_profit DESC
LIMIT 10;


-- =========================================
-- SECTION 21: Top 10 Loss-Making Products
-- =========================================

SELECT
    product_id,
    product_name,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY product_id, product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 10;


-- =========================================
-- SECTION 22: Average Discount by Category
-- =========================================

SELECT
    category,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY category
ORDER BY average_discount_percentage DESC;

-- =========================================
-- SECTION 23: Order Size Analysis
-- =========================================

WITH order_summary AS (
    SELECT
        order_id,
        SUM(sales) AS order_sales,
        SUM(profit) AS order_profit,
        SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY order_id
),
classified_orders AS (
    SELECT
        order_id,
        order_sales,
        order_profit,
        CASE
            WHEN order_sales < 100 THEN 'Small'
            WHEN order_sales < 500 THEN 'Medium'
            ELSE 'Large'
        END AS order_size,
        CASE
            WHEN order_sales < 100 THEN 1
            WHEN order_sales < 500 THEN 2
            ELSE 3
        END AS sort_order
    FROM order_summary
)
SELECT
    order_size,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_sales), 2) AS total_sales,
    ROUND(SUM(order_profit), 2) AS total_profit,
    ROUND(AVG(order_profit), 2) AS average_profit_per_order
FROM classified_orders
GROUP BY order_size, sort_order
ORDER BY sort_order;
    CASE order_size
        WHEN 'Small' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Large' THEN 3
    END;


-- =========================================
-- SECTION 24: Customer Profitability Ranking
-- =========================================

WITH customer_summary AS (
    SELECT
        customer_id,
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM orders
    GROUP BY customer_id, customer_name
)
SELECT
    customer_id,
    customer_name,
    total_orders,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(total_profit, 2) AS total_profit,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM customer_summary
ORDER BY profit_rank
LIMIT 20;


-- =========================================
-- SECTION 25: Overall Business Performance
-- =========================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity_sold,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS overall_profit_margin_percentage,
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM orders;
