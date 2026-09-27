-- ============================================================
-- SQL Sales Analysis
-- 02 - Basic Sales Analysis
-- ============================================================

-- 1. Total transactions
SELECT
    COUNT(*) AS total_transactions
FROM sales_clean;


-- 2. Total revenue
SELECT
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_clean;


-- 3. Average transaction-line revenue
SELECT
    ROUND(AVG(revenue), 2) AS avg_line_revenue
FROM sales_clean;


-- 4. Total quantity sold
SELECT
    SUM(quantity) AS total_quantity_sold
FROM sales_clean;


-- 5. Number of unique products
SELECT
    COUNT(DISTINCT stock_code) AS unique_products
FROM sales_clean;


-- 6. Number of unique customers
SELECT
    COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_clean;


-- 7. Number of countries
SELECT
    COUNT(DISTINCT country) AS countries_served
FROM sales_clean;


-- 8. Overall sales KPIs
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT stock_code) AS unique_products,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS total_quantity_sold,
    ROUND(AVG(revenue), 2) AS avg_line_revenue
FROM sales_clean;