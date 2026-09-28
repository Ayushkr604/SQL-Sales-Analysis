-- ============================================================
-- SQL Sales Analysis
-- 03 - Customer Analysis
-- ============================================================

-- 1. Top 10 customers by revenue
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Top 10 customers by number of orders
SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- 3. Repeat vs one-time customers
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;

-- 4. Customer revenue segmentation
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(revenue) AS total_revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_revenue < 100 THEN 'Low Value'
        WHEN total_revenue < 1000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_revenue), 2) AS segment_revenue
FROM customer_revenue
GROUP BY customer_segment
ORDER BY segment_revenue DESC;

-- 5. Average revenue per customer
SELECT
    ROUND(
        SUM(revenue) / COUNT(DISTINCT customer_id),
        2
    ) AS average_customer_revenue
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL;

-- 6. Customer lifetime value
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

-- 7. Customer revenue ranking
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

-- 8. Repeat customer revenue vs one-time customer revenue
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

-- 9. Revenue concentration among top 10 customers
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
