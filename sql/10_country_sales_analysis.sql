
-- ============================================================
-- SQL Sales Analysis
-- 10 - Country Sales Analysis
-- ============================================================

-- Rank countries by completed sales revenue
SELECT
    country,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(revenue) AS total_revenue,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT invoice_no),
        2
    ) AS revenue_per_order
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
  AND TRIM(CAST(customer_id AS TEXT)) <> ''
GROUP BY country
ORDER BY total_revenue DESC;
