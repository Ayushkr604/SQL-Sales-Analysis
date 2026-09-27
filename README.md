# SQL Sales Analysis

## 📊 Project Overview

This project analyzes retail sales data using SQL and SQLite to identify
sales trends, customer behavior, product performance, and business insights.

The project demonstrates practical SQL skills including aggregation,
filtering, CTEs, subqueries, and window functions.

---

## 🎯 Business Questions

The analysis answers questions such as:

- What is the total revenue generated?
- What is the average order value?
- How many customers and products are there?
- Which countries generate the most revenue?
- Which products generate the most revenue?
- Which products sell the highest quantities?
- Who are the highest-value customers?
- What percentage of customers are repeat customers?
- How does revenue change over time?
- Which months generate the highest sales?
- How much revenue comes from repeat customers?
- How concentrated is revenue among top customers?
- What is the impact of cancelled orders?

---

## 🗂️ Project Structure

```text
SQL-Sales-Analysis/
│
├── data/
│   └── .gitkeep
│
├── database/
│   └── sales_analysis.db
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_basic_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_time_analysis.sql
│   ├── 06_advanced_analysis.sql
│   └── 07_business_insights.sql
│
├── screenshots/
│
├── .gitignore
└── README.md


---

## 📦 Dataset

The project uses the **Online Retail** dataset containing transactional
retail sales data.

The dataset contains:

- Invoice number
- Product/Stock code
- Product description
- Quantity
- Invoice date
- Unit price
- Customer ID
- Country

The raw dataset is excluded from GitHub using `.gitignore`.

---

## 🛠️ Tools & Technologies

- SQL
- SQLite
- Git & GitHub
- GitHub Codespaces
- Python / Pandas for dataset preparation

---

## 🧹 Data Preparation

A cleaned analytical table called `sales_clean` was created from the raw
transaction data.

Revenue was calculated as:

quantity * unit_price

Cancelled invoices were identified using invoice numbers beginning with
`C`.

For completed-sales analysis, cancelled invoices were excluded using:
```sql
WHERE invoice_no NOT LIKE 'C%'


---

## 📸 Analysis Results

### Executive KPIs

![Executive KPIs](screenshots/executive_kpis.png)

### Top Customers

![Top Customers](screenshots/top_customers.png)

### Top Products by Revenue

![Top Products](screenshots/top_products_revenue.png)

### Monthly Revenue

![Monthly Revenue](screenshots/monthly_revenue.png)

### Customer Segmentation

![Customer Segmentation](screenshots/customer_segments.png)

---