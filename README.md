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

## 💡 Business Insights

The SQL analysis identified several key patterns in customer behaviour, product performance, and sales trends:

- **£10.64M in completed revenue** was generated across **22,064 completed orders**, with an **average order value of £482.44**.
- The dataset contains **4,373 customers** and **4,070 products**.
- Among customers with usable customer IDs, **2,845 were repeat customers** and **1,494 were one-time customers**.
- **November 2011** was the strongest sales month, generating approximately **£1.51M** in revenue from **3,021 orders**.
- **Customer 14646** generated **£280,206.02** across 74 orders.
- **Customer 16446** generated **£168,472.50 from only 2 orders**, highlighting a high-value customer pattern worth further investigation.
- **REGENCY CAKESTAND 3 TIER** generated **£174,484.74** in revenue.
- **PAPER CRAFT, LITTLE BIRDIE** generated **£168,469.60** in revenue.
- The dataset contains **3,836 cancelled orders** compared with **22,064 completed orders**.
- Customer-level analysis excluded blank customer IDs to avoid treating missing customer information as an actual customer.

> **Note:** Completed-sales analysis excludes invoices beginning with `C`, which represent cancelled transactions.

---

## 🧠 SQL Techniques Demonstrated

- Aggregations using `SUM()`, `AVG()`, `COUNT()`
- Filtering with `WHERE`
- Grouping with `GROUP BY`
- Conditional logic using `CASE`
- Common Table Expressions (CTEs)
- Subqueries
- Window functions
- `RANK()`
- `LAG()`
- Customer segmentation
- Revenue and order analysis
- Time-series analysis using `strftime()`
- Cancellation analysis
- Revenue concentration analysis

---

## 📈 Key KPI Snapshot

| KPI | Value |
|---|---:|
| Completed Orders | 22,064 |
| Customers | 4,373 |
| Products | 4,070 |
| Completed Revenue | £10,644,560.42 |
| Average Order Value | £482.44 |
| Repeat Customers* | 2,845 |
| One-Time Customers* | 1,494 |
| Cancelled Orders | 3,836 |

\*Based on customers with usable customer IDs.

---