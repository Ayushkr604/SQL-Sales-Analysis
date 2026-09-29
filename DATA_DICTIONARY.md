# Data Dictionary

## `sales_clean` Table

The `sales_clean` table is the cleaned analytical table used throughout the SQL Sales Analysis project.

| Column | Data Type | Description |
|---|---|---|
| `invoice_no` | TEXT | Unique invoice/order identifier. Invoices beginning with `C` represent cancelled transactions. |
| `stock_code` | TEXT | Product or stock identifier. |
| `description` | TEXT | Product description. |
| `quantity` | INTEGER | Number of units in the transaction line. |
| `invoice_date` | TEXT | Date and time of the transaction. |
| `unit_price` | REAL | Price per unit. |
| `customer_id` | REAL | Customer identifier. May be missing for some transactions. |
| `country` | TEXT | Country associated with the transaction. |
| `revenue` | REAL | Calculated transaction revenue: `quantity × unit_price`. |

## Data Preparation Rules

- Leading and trailing whitespace is removed from text fields.
- `revenue` is calculated from `quantity × unit_price`.
- Cancelled transactions are identified using invoice numbers beginning with `C`.
- Completed-sales analysis excludes cancelled invoices using:

```sql
WHERE invoice_no NOT LIKE 'C%'