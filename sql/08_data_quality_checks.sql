
-- ============================================================
-- SQL Sales Analysis
-- 08 - Data Quality Checks
-- ============================================================

-- 1. Check total rows in the cleaned table
SELECT
    COUNT(*) AS total_rows
FROM sales_clean;

-- 2. Check for missing invoice numbers
SELECT
    COUNT(*) AS missing_invoice_numbers
FROM sales_clean
WHERE invoice_no IS NULL
   OR TRIM(invoice_no) = '';

-- 3. Check for missing product codes
SELECT
    COUNT(*) AS missing_stock_codes
FROM sales_clean
WHERE stock_code IS NULL
   OR TRIM(stock_code) = '';

-- 4. Check for missing invoice dates
SELECT
    COUNT(*) AS missing_invoice_dates
FROM sales_clean
WHERE invoice_date IS NULL
   OR TRIM(invoice_date) = '';

-- 5. Check for invalid negative unit prices
SELECT
    COUNT(*) AS negative_unit_prices
FROM sales_clean
WHERE unit_price < 0;

-- 6. Check for zero quantities
SELECT
    COUNT(*) AS zero_quantity_rows
FROM sales_clean
WHERE quantity = 0;

-- 7. Check for missing customer IDs
SELECT
    COUNT(*) AS missing_customer_ids
FROM sales_clean
WHERE customer_id IS NULL
   OR TRIM(CAST(customer_id AS TEXT)) = '';

-- 8. Check for duplicate transaction lines
SELECT
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price,
    COUNT(*) AS duplicate_count
FROM sales_clean
GROUP BY
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC
LIMIT 20;
