-- ============================================================
-- SQL Sales Analysis
-- 06 - Advanced Analysis
-- ============================================================

-- 1. Customer lifetime value
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(revenue), 2) AS lifetime_value
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 20;

-- 2. Customer revenue ranking
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(revenue) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    customer_id,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM customer_sales
ORDER BY revenue_rank
LIMIT 20;

-- 3. Top products within each country
WITH product_country AS (
    SELECT
        country,
        stock_code,
        description,
        SUM(revenue) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY country, stock_code, description
),
ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY country
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_country
)
SELECT
    country,
    stock_code,
    description,
    ROUND(revenue, 2) AS revenue,
    product_rank
FROM ranked
WHERE product_rank <= 3
ORDER BY country, product_rank;

-- 4. Repeat customer revenue vs one-time customer revenue
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS orders,
        SUM(revenue) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    ROUND(
        SUM(CASE WHEN orders > 1 THEN revenue ELSE 0 END), 2
    ) AS repeat_customer_revenue,
    ROUND(
        SUM(CASE WHEN orders = 1 THEN revenue ELSE 0 END), 2
    ) AS one_time_customer_revenue
FROM customer_orders;

-- 5. Revenue concentration among top 10 customers
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(revenue) AS revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
),
ranked AS (
    SELECT
        *,
        RANK() OVER (ORDER BY revenue DESC) AS rnk
    FROM customer_sales
)
SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN rnk <= 10 THEN revenue ELSE 0 END
        ) / SUM(revenue),
        2
    ) AS top_10_customer_revenue_pct
FROM ranked;
