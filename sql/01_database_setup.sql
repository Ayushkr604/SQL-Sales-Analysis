-- ============================================================
-- SQL Sales Analysis
-- 01 - Database Setup
-- ============================================================

-- Remove old tables if they exist
DROP TABLE IF EXISTS sales_raw;
DROP TABLE IF EXISTS sales_clean;

-- Create raw sales table
CREATE TABLE sales_raw (
    invoice_no TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INTEGER,
    invoice_date TEXT,
    unit_price REAL,
    customer_id REAL,
    country TEXT
);

-- Import CSV data before running the cleaning step:
.mode csv
.import --skip 1 data/sales_data.csv sales_raw

-- Create cleaned analytical table
CREATE TABLE sales_clean AS
SELECT
    TRIM(invoice_no) AS invoice_no,
    TRIM(stock_code) AS stock_code,
    TRIM(description) AS description,
    quantity,
    invoice_date,
    unit_price,
    customer_id,
    TRIM(country) AS country,
    quantity * unit_price AS revenue
FROM sales_raw;

-- Verify the table
SELECT COUNT(*) AS total_rows
FROM sales_clean;