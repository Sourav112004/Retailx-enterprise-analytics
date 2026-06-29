## 📖 Project Documentation

- [Database Design Decisions](docs/Database_Design_Decisions.md)

# RetailX Enterprise Analytics

A comprehensive retail analytics project covering database design, data analysis, and business intelligence reporting.

## Project Structure

```
RetailX Enterprise Analytics
│
├── sql/                         # Database schema & queries
│   ├── 01_create_customers.sql
│   ├── 02_create_orders.sql
│   ├── 03_create_products.sql
│   ├── 04_create_sellers.sql
│   ├── 05_create_order_items.sql
│   ├── 06_create_payments.sql
│   └── 07_create_reviews.sql
│
├── data/                        # Raw and processed datasets
├── powerbi/                     # Power BI report files (.pbix)
├── python/                      # Python scripts for analysis
├── docs/                        # Documentation and notes
└── README.md
```

## Getting Started

1. Run the SQL scripts in order (01 → 07) to set up the database schema.
2. Load sample data from the `data/` folder.
3. Use the Python scripts in `python/` for data processing and analysis.
4. Open Power BI reports from the `powerbi/` folder for dashboards.

## Tools Used

- **MySQL** – Database
- **MySQL Workbench** – SQL development
- **Python** – Data analysis
- **Power BI** – Data visualization


