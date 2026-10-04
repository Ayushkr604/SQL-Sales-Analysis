
-- ============================================================
-- SQL Sales Analysis
-- 09 - Customer Retention Analysis
-- ============================================================

-- 1. Classify customers by number of completed orders
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS total_orders
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
      AND TRIM(CAST(customer_id AS TEXT)) <> ''
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_orders
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- 2. Monthly returning-customer activity
WITH customer_months AS (
    SELECT DISTINCT
        customer_id,
        SUBSTR(invoice_date, 1, 7) AS purchase_month
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
      AND customer_id IS NOT NULL
      AND TRIM(CAST(customer_id AS TEXT)) <> ''
)
SELECT
    purchase_month,
    COUNT(*) AS active_customers
FROM customer_months
GROUP BY purchase_month
ORDER BY purchase_month;
