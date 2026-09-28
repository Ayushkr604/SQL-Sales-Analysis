-- ============================================================
-- SQL Sales Analysis
-- 07 - Business Insights
-- ============================================================

-- 1. Cancellation impact
SELECT
    ROUND(SUM(CASE
        WHEN invoice_no LIKE 'C%' THEN revenue
        ELSE 0
    END), 2) AS cancelled_revenue,

    ROUND(SUM(CASE
        WHEN invoice_no NOT LIKE 'C%' THEN revenue
        ELSE 0
    END), 2) AS completed_revenue
FROM sales_clean;

-- 2. Cancellation rate
WITH order_status AS (
    SELECT
        invoice_no,
        CASE
            WHEN invoice_no LIKE 'C%' THEN 'Cancelled'
            ELSE 'Completed'
        END AS order_status
    FROM sales_clean
    GROUP BY invoice_no
)
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellation_orders,
    ROUND(
        100.0 * SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM order_status;

-- 3. Average order value for completed orders
WITH completed_orders AS (
    SELECT
        invoice_no,
        SUM(revenue) AS order_revenue
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY invoice_no
)
SELECT
    ROUND(AVG(order_revenue), 2) AS completed_order_aov
FROM completed_orders;

-- 4. Average items per completed order
WITH completed_orders AS (
    SELECT
        invoice_no,
        SUM(quantity) AS total_items
    FROM sales_clean
    WHERE invoice_no NOT LIKE 'C%'
    GROUP BY invoice_no
)
SELECT
    ROUND(AVG(total_items), 2) AS avg_items_per_order
FROM completed_orders;

-- 5. Revenue per customer by country
SELECT
    country,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT customer_id),
        2
    ) AS revenue_per_customer
FROM sales_clean
WHERE invoice_no NOT LIKE 'C%'
  AND customer_id IS NOT NULL
GROUP BY country
ORDER BY revenue_per_customer DESC
LIMIT 15;

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


-- 7. Executive KPI dashboard
SELECT
    (
        SELECT COUNT(DISTINCT invoice_no)
        FROM sales_clean
        WHERE invoice_no NOT LIKE 'C%'
    ) AS completed_orders,

    (
        SELECT COUNT(DISTINCT customer_id)
        FROM sales_clean
        WHERE invoice_no NOT LIKE 'C%'
          AND customer_id IS NOT NULL
    ) AS customers,

    (
        SELECT COUNT(DISTINCT stock_code)
        FROM sales_clean
        WHERE invoice_no NOT LIKE 'C%'
    ) AS products,

    (
        SELECT ROUND(SUM(revenue), 2)
        FROM sales_clean
        WHERE invoice_no NOT LIKE 'C%'
    ) AS completed_revenue,

    (
        SELECT ROUND(
            SUM(order_revenue) / COUNT(*),
            2
        )
        FROM (
            SELECT invoice_no, SUM(revenue) AS order_revenue
            FROM sales_clean
            WHERE invoice_no NOT LIKE 'C%'
            GROUP BY invoice_no
        )
    ) AS average_order_value,

    (
        SELECT ROUND(
            SUM(order_quantity) * 1.0 / COUNT(*),
            2
        )
        FROM (
            SELECT invoice_no, SUM(quantity) AS order_quantity
            FROM sales_clean
            WHERE invoice_no NOT LIKE 'C%'
            GROUP BY invoice_no
        )
    ) AS avg_items_per_order;
