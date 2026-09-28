-- ============================================================
-- SQL Sales Analysis
-- 04 - Product Analysis
-- ============================================================

-- 1. Top 10 products by revenue
SELECT
    stock_code,
    description,
    ROUND(SUM(revenue), 2) AS total_revenue,
    SUM(quantity) AS total_quantity
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY stock_code, description
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Top 10 products by quantity sold
SELECT
    stock_code,
    description,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY stock_code, description
ORDER BY total_quantity DESC
LIMIT 10;

-- 3. Average selling price by product
SELECT
    stock_code,
    description,
    ROUND(AVG(unit_price), 2) AS avg_unit_price,
    SUM(quantity) AS total_quantity
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND unit_price > 0
GROUP BY stock_code, description
ORDER BY total_quantity DESC
LIMIT 20;

-- 4. Products with the highest number of orders
SELECT
    stock_code,
    description,
    COUNT(DISTINCT invoice_no) AS order_count,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY stock_code, description
ORDER BY order_count DESC
LIMIT 10;

-- 5. Product revenue contribution
WITH product_sales AS (
    SELECT
        stock_code,
        description,
        SUM(revenue) AS total_revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY stock_code, description
)
SELECT
    stock_code,
    description,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        100.0 * total_revenue /
        SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- 6. High-revenue products
SELECT
    stock_code,
    description,
    ROUND(SUM(revenue), 2) AS revenue,
    SUM(quantity) AS quantity_sold,
    ROUND(AVG(unit_price), 2) AS avg_price
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY stock_code, description
HAVING SUM(revenue) > 10000
ORDER BY revenue DESC;
