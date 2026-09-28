-- ============================================================
-- SQL Sales Analysis
-- 05 - Time Analysis
-- ============================================================

-- 1. Revenue by year and month
SELECT
    strftime('%Y', invoice_date) AS year,
    strftime('%m', invoice_date) AS month,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY year, month
ORDER BY year, month;

-- 2. Revenue by day of week
SELECT
    CASE strftime('%w', invoice_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY strftime('%w', invoice_date)
ORDER BY total_revenue DESC;

-- 3. Revenue by hour
SELECT
    strftime('%H', invoice_date) AS hour,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY hour
ORDER BY total_revenue DESC;

-- 4. Monthly revenue growth
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', invoice_date) AS month,
        SUM(revenue) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY month
),
monthly_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        100.0 * (revenue - previous_month_revenue)
        / previous_month_revenue,
        2
    ) AS growth_pct
FROM monthly_growth
ORDER BY month;

-- 5. Best sales months
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', invoice_date) AS month,
        ROUND(SUM(revenue), 2) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY month
)
SELECT
    month,
    revenue
FROM monthly_sales
ORDER BY revenue DESC
LIMIT 5;

-- 6. Monthly orders, quantity, revenue and AOV
SELECT
    strftime('%Y-%m', invoice_date) AS month,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice_no),
        2
    ) AS monthly_aov
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
GROUP BY month
ORDER BY month;
