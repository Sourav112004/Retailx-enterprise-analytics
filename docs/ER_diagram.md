#  Entity Relationship (ER) Diagram

## Overview

The RetailX data model follows a **star schema-inspired relational design**, where transactional data is stored in fact tables and descriptive information is maintained in dimension tables. This structure enables efficient SQL analytics, reusable business views, and optimized Power BI reporting.

---

# ER Diagram

> Replace the image below with your exported ER Diagram.

<p align="center">
  <img src="../images/ER_Diagram.png" width="950">
</p>

---

# Database Structure

The RetailX database consists of seven primary business entities.

| Table | Description |
|--------|-------------|
| Customers | Customer demographic and location information |
| Orders | Order lifecycle, purchase, approval, and delivery timestamps |
| Order_Items | Product-level details for every order |
| Products | Product catalog and category information |
| Sellers | Marketplace seller information |
| Order_Payments | Payment methods and transaction values |
| Order_Reviews | Customer review scores and feedback |

---

# Relationships

## Customers → Orders

**Relationship**

```
One Customer
      │
      └──────< Many Orders
```

Each customer can place multiple orders.

Primary Key

```
customers.customer_id
```

Foreign Key

```
orders.customer_id
```

---

## Orders → Order Items

**Relationship**

```
One Order
      │
      └──────< Multiple Order Items
```

An order may contain multiple products.

Primary Key

```
orders.order_id
```

Foreign Key

```
order_items.order_id
```

---

## Products → Order Items

```
One Product
      │
      └──────< Many Order Items
```

A product can appear in many different customer orders.

Primary Key

```
products.product_id
```

Foreign Key

```
order_items.product_id
```

---

## Sellers → Order Items

```
One Seller
      │
      └──────< Many Order Items
```

Each seller fulfills multiple products across many orders.

Primary Key

```
sellers.seller_id
```

Foreign Key

```
order_items.seller_id
```

---

## Orders → Payments

```
One Order
      │
      └──────< Multiple Payment Records
```

Orders may be paid using multiple payment methods.

Primary Key

```
orders.order_id
```

Foreign Key

```
order_payments.order_id
```

---

## Orders → Reviews

```
One Order
      │
      └────── One Review
```

Each completed order can receive one customer review.

Primary Key

```
orders.order_id
```

Foreign Key

```
order_reviews.order_id
```

---

# Data Model Design Decisions

The database was intentionally normalized to reduce redundancy and improve maintainability.

Key design considerations:

- Normalized relational schema
- Primary and foreign key constraints
- Business entities separated into logical tables
- Optimized joins for analytical SQL queries
- Reusable SQL Views built on top of transactional tables

---

# Analytical Layer

Rather than querying transactional tables directly in Power BI, business logic was encapsulated within SQL Views.

The analytical layer includes:

- Executive Business Performance
- Product Performance
- Seller Performance
- Customer Lifetime Value (CLV)
- Customer Retention
- Monthly Business Performance
- Delivery Performance

This approach separates:

```
Raw Data
      ↓
Relational Database
      ↓
Business SQL Views
      ↓
Power BI Dashboards
```

making the solution scalable, maintainable, and easier to extend.

---

# Business Benefits

This data model enables:

- Accurate revenue reporting
- Customer behavior analysis
- Product performance tracking
- Seller benchmarking
- Logistics performance monitoring
- Executive KPI reporting

The separation of transactional tables from analytical SQL Views ensures that reporting logic remains centralized, reusable, and consistent across all dashboards.
