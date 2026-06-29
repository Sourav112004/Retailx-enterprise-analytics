
#  Database Design Decisions

## RetailX Enterprise Analytics

---

##  Overview

This document explains the reasoning behind the database design decisions made during the development of the **RetailX Enterprise Analytics** project.

Instead of directly importing the dataset into MySQL, the dataset was first profiled using **Python (Pandas)** to understand:

- Missing values
- Duplicate records
- Candidate primary keys
- Data types
- Maximum text lengths

The database schema was then designed based on the findings.

---

# 1. Primary Key Strategy

## Customers

| Decision | Reason |
|----------|--------|
| `customer_id` as Primary Key | Every customer has a unique UUID.|

---

## Orders

| Decision | Reason |
|----------|--------|
| `order_id` as Primary Key | Every order is uniquely identified. |
| `customer_id` as Foreign Key | Each order belongs to one customer.|

---

## Order Items

| Decision | Reason |
|----------|--------|
| Composite Primary Key (`order_id`, `order_item_id`) | `order_item_id` restarts from 1 for every order and therefore cannot uniquely identify a record by itself.|

---

## Payments

| Decision | Reason |
|----------|--------|
| Composite Primary Key (`order_id`, `payment_sequential`) | A single order can contain multiple payment transactions.|

---

## Reviews

| Decision | Reason |
|----------|--------|
| Composite Primary Key (`review_id`, `order_id`) | Data profiling revealed duplicate `review_id` values associated with different orders.|

---

# 2. Foreign Key Relationships

```
customers
    │
    ▼
orders
    │
    ├──────────────┐
    ▼              ▼
order_items     payments
    │
    ▼
reviews

products ─────┐
              ▼
         order_items

sellers ──────┘
```

---

# 3. Data Type Decisions

## UUID Columns

```sql
CHAR(32)
```

### Reason

- Dataset uses fixed-length UUIDs.
- More efficient than VARCHAR for fixed-length identifiers.
- Better indexing performance.

---

## Monetary Values

```sql
DECIMAL(10,2)
```

### Reason

Financial values should never use FLOAT because floating-point arithmetic can introduce rounding errors.

---

## Variable Length Text

```sql
VARCHAR
```

Used for:

- order_status
- payment_type
- product_category_name
- seller_city

Reason:

Values have varying lengths but are expected to remain relatively short.

---

## Review Messages

```sql
TEXT
```

### Reason

Although the current dataset has a maximum review length of **208 characters**, production systems should not assume future reviews will remain within that limit.

TEXT provides greater flexibility for user-generated content.

---

# 4. Nullable Columns

Nullability was determined after profiling the dataset using Pandas.

Examples include:

- review_comment_title
- review_comment_message
- order_approved_at
- order_delivered_customer_date

Reason:

These NULL values represent valid business scenarios rather than invalid data.

Examples:

- Customer submitted only a rating without writing a review.
- Order was cancelled before approval.
- Delivery never occurred.

---

# 5. Data Profiling Decisions

The following analyses were performed before designing the schema.

## Missing Values

```python
df.isnull().sum()
```

Purpose:

Identify columns that legitimately require NULL values.

---

## Duplicate Detection

```python
df.duplicated().sum()
```

Purpose:

Identify duplicate records before selecting primary keys.

---

## Candidate Primary Keys

```python
reviews['review_id'].nunique()
reviews['order_id'].nunique()
```

Purpose:

Verify uniqueness before assigning primary keys.

---

## Maximum Text Length

```python
reviews['review_comment_message'].str.len().max()
```

Result:

```
Maximum review length = 208 characters
```

Decision:

Use `TEXT` instead of limiting the column length.

---

# 6. Normalization

The schema follows relational database normalization principles.

Separate entities were created for:

- Customers
- Orders
- Products
- Sellers
- Payments
- Reviews

This reduces redundancy and improves maintainability.

---

# 7. Scalability Decisions

Several decisions were made with future scalability in mind.

| Decision | Reason |
|----------|--------|
| CHAR(32) for UUIDs | Fixed-length identifiers |
| DECIMAL for currency | Accurate financial calculations |
| TEXT for review messages | Supports future growth |
| Composite Primary Keys | Reflects real business relationships |

---

# 8. Engineering Workflow

The project follows the workflow below instead of importing data directly.

```
CSV Files
      │
      ▼
Python (Pandas)

      │
      ▼
Data Profiling

      │
      ▼
Database Design

      │
      ▼
MySQL Database

      │
      ▼
Data Quality Checks

      │
      ▼
SQL Analysis

      │
      ▼
Power BI Dashboard
```

---

#  Technologies Used

- MySQL Workbench 8.0
- Python
- Pandas
- SQL
- Power BI
- Git
- GitHub

---

#  Next Steps

- Import CSV datasets into MySQL
- Validate row counts
- Verify foreign key integrity
- Perform data quality assessment
- Build analytical SQL queries
- Develop interactive Power BI dashboards
