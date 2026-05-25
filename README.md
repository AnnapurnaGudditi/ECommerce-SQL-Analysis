# 🛒 E-Commerce Sales Analysis using SQL

A comprehensive SQL-based analytics project demonstrating advanced database querying techniques on e-commerce data. This project showcases practical implementations of SQL concepts from basic to advanced levels with real-world business insights.

---

## 📋 Table of Contents
- [Overview](#overview)
- [Project Highlights](#project-highlights)
- [Database Schema](#database-schema)
- [Technologies Used](#technologies-used)
- [Query Categories](#query-categories)
- [Installation & Setup](#installation--setup)
- [Key Business Insights](#key-business-insights)
- [SQL Concepts Covered](#sql-concepts-covered)
- [Files Structure](#files-structure)
- [How to Use](#how-to-use)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

This project analyzes e-commerce sales transactions across multiple Indian cities using structured SQL queries. It provides actionable business intelligence through data-driven queries covering customer behavior, product performance, revenue analysis, and operational metrics.

**Dataset Scope:**
- 10 customers across major Indian cities
- 10 products across 4 categories
- 20 orders with complete transaction history
- Comprehensive order line-item details

---

## ✨ Project Highlights

✅ **20 Production-Ready Queries** - From basic aggregations to advanced window functions  
✅ **Complete Database Setup** - DDL scripts for tables and relationships  
✅ **Real Business Scenarios** - Revenue analysis, customer segmentation, inventory tracking  
✅ **Advanced SQL Techniques** - CTEs, Window Functions, Subqueries, Case Statements  
✅ **Well-Documented Code** - Comments explaining each query's purpose  
✅ **Business Insights** - Actionable findings from data analysis  

---

## 🗄️ Database Schema

### Tables Structure

```
┌─────────────────┐
│   CUSTOMERS     │
├─────────────────┤
│ customer_id(PK) │
│ customer_name   │
│ email           │
│ city            │
│ state           │
│ registration_   │
│ date            │
└─────────────────┘
         │
         │ 1:N
         ▼
┌─────────────────┐
│    ORDERS       │
├─────────────────┤
│ order_id (PK)   │
│ customer_id(FK) │
│ order_date      │
│ total_amount    │
│ status          │
└─────────────────┘
         │
         │ 1:N
         ▼
┌──────────────────────┐
│   ORDER_ITEMS        │
├──────────────────────┤
│ item_id (PK)         │
│ order_id (FK)        │
│ product_id (FK)      │
│ quantity             │
│ unit_price           │
└──────────────────────┘
         │
         └──────────────┐
┌─────────────────┐    │
│   PRODUCTS      │◄───┘
├─────────────────┤
│ product_id(PK)  │
│ product_name    │
│ category        │
│ price           │
│ stock_quantity  │
└─────────────────┘
```

### Table Details

| Table | Records | Purpose |
|-------|---------|---------|
| **customers** | 10 | Store customer demographics & registration |
| **products** | 10 | Maintain product catalog with inventory |
| **orders** | 20 | Track order transactions and status |
| **order_items** | 20 | Store line-item details for each order |

---

## 🛠️ Technologies Used

| Technology | Version | Purpose |
|------------|---------|---------|
| **MySQL** | 8.0+ | Relational Database Management |
| **MySQL Workbench** | 8.0+ | IDE for query development & debugging |
| **SQL** | ISO/IEC 9075 | Query language for data analysis |

---

## 📊 Query Categories

### 🔵 Basic Queries (Q1-Q3)
Foundational SQL concepts - COUNT, SUM aggregations, filtering
- Q1: Total customer count
- Q2: Total orders count
- Q3: Total revenue calculation

### 🟢 Intermediate Queries (Q4-Q8)
JOIN operations, GROUP BY, filtering with WHERE/HAVING
- Q4: Orders by status
- Q5: Top 5 customers by spending
- Q6: Revenue by city
- Q7: Best selling products
- Q8: Revenue by category

### 🔴 Advanced Queries (Q9-Q20)
Window functions, CTEs, complex aggregations, subqueries
- Q9: Monthly revenue trends
- Q10: Customers with no orders (LEFT JOIN)
- Q11: Average order value by city
- Q12: Cancellation rate analysis
- Q13: Repeat customer identification
- Q14: Top product per category (RANK window function)
- Q15: Customer ranking by revenue (Window functions)
- Q16: Running total revenue (SUM OVER)
- Q17: Low stock products
- Q18: Revenue contribution percentage
- Q19: High-value customer segmentation (CTE)
- Q20: Executive business summary (Subqueries)

---

## 📥 Installation & Setup

### Prerequisites
- MySQL Server 5.7+ or 8.0+
- MySQL Workbench (recommended)
- SQL IDE or terminal access

### Step 1: Clone Repository
```bash
git clone https://github.com/AnnapurnaGudditi/ECommerce-SQL-Analysis.git
cd ECommerce-SQL-Analysis
```

### Step 2: Create Database
```sql
-- Open MySQL terminal or Workbench
-- Run the entire ecommerce_analysis.sql file
mysql -u root -p < ecommerce_analysis.sql
```

### Step 3: Verify Setup
```sql
-- Check if database exists
SHOW DATABASES;

-- Switch to database
USE ecommerce_analysis;

-- Verify tables
SHOW TABLES;

-- Check data
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
```

---

## 💡 Key Business Insights

### 📈 Revenue Metrics
- **Total Revenue (Delivered Orders):** ₹3,09,900
- **Average Order Value:** ₹15,495
- **Cancellation Rate:** 10% (2 out of 20 orders)

### 🏙️ Geographic Performance
- **Top Revenue City:** Hyderabad
- **Orders by City:** Chennai (3), Delhi (2), Hyderabad (3), Others

### 👥 Customer Insights
- **Total Customers:** 10
- **Top Customer:** Rahul Sharma (₹1,13,000 spent)
- **Repeat Customers:** 8 customers with multiple orders
- **No Orders:** 0 customers (100% order rate)

### 📦 Product Performance
- **Top Category:** Electronics (highest revenue)
- **Best Selling Product:** Mobile Phone
- **Low Stock Items:** 3 products with stock < 50

### 📅 Temporal Trends
- **Peak Order Month:** October 2023
- **Order Status Breakdown:**
  - Delivered: 18 (90%)
  - Pending: 1 (5%)
  - Cancelled: 2 (10%)

---

## 📚 SQL Concepts Covered

### Core Concepts
- ✅ **DDL:** CREATE TABLE, PRIMARY KEY, FOREIGN KEY
- ✅ **DML:** INSERT, SELECT
- ✅ **Basic Queries:** WHERE, ORDER BY, LIMIT
- ✅ **Aggregation:** COUNT, SUM, AVG, MIN, MAX

### Intermediate Concepts
- ✅ **GROUP BY & HAVING:** Data segmentation and filtering
- ✅ **JOINs:** INNER JOIN, LEFT JOIN relationships
- ✅ **Subqueries:** Nested queries for complex logic
- ✅ **Date Functions:** MONTH(), MONTHNAME(), DATE calculations

### Advanced Concepts
- ✅ **Window Functions:** RANK(), SUM OVER(), PARTITION BY
- ✅ **Common Table Expressions (CTEs):** WITH clause for readability
- ✅ **Case Statements:** Conditional logic in queries
- ✅ **Running Totals:** Cumulative aggregations
- ✅ **Query Optimization:** Efficient joins and filtering

---

## 📁 Files Structure

```
ECommerce-SQL-Analysis/
├── README.md                      # Project documentation (this file)
├── ecommerce_analysis.sql         # Main SQL file with all queries
├── QUERY_GUIDE.md                 # Detailed query explanations
├── CONTRIBUTING.md                # Contribution guidelines
└── LICENSE                        # MIT License
```

### File Descriptions

| File | Description |
|------|-------------|
| **ecommerce_analysis.sql** | Complete SQL script with DDL (table creation), DML (data insertion), and all 20 analytical queries |
| **QUERY_GUIDE.md** | Detailed documentation of each query with explanations, use cases, and output |
| **CONTRIBUTING.md** | Guidelines for contributing improvements |
| **LICENSE** | MIT License for open-source usage |

---

## 🚀 How to Use

### Option 1: Run All Queries at Once
```sql
-- Execute the entire ecommerce_analysis.sql file
mysql -u your_username -p your_database < ecommerce_analysis.sql
```

### Option 2: Run Individual Queries
```sql
USE ecommerce_analysis;

-- Example: Get top 5 customers
SELECT c.customer_name,
       c.city,
       SUM(total_amount) as total_spent
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;
```

### Option 3: Modify Queries for Your Analysis
```sql
-- Example: Get top 3 instead of top 5
SELECT c.customer_name,
       c.city,
       SUM(total_amount) as total_spent
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 3;  -- Changed from 5 to 3
```

---

## 💻 Query Examples

### Example 1: Top 5 Customers by Spending
```sql
SELECT c.customer_name,
       c.city,
       SUM(total_amount) as total_spent
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;
```

### Example 2: Revenue by Category
```sql
SELECT p.category,
       COUNT(oi.item_id) as total_orders,
       SUM(oi.quantity * oi.unit_price) as category_revenue
FROM products p
JOIN order_items as oi ON p.product_id = oi.product_id
JOIN orders as o ON oi.order_id = o.order_id
WHERE status = 'Delivered'
GROUP BY p.category
ORDER BY category_revenue DESC;
```

### Example 3: Customer Ranking (Window Functions)
```sql
SELECT c.customer_name,
       c.city,
       SUM(o.total_amount) as total_spent,
       RANK() OVER (ORDER BY SUM(o.total_amount) DESC) as revenue_rank
FROM customers as c
JOIN orders as o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city;
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to help:

1. **Report Issues:** Found a bug? [Open an issue](https://github.com/AnnapurnaGudditi/ECommerce-SQL-Analysis/issues)
2. **Suggest Improvements:** Have ideas? [Discuss in issues](https://github.com/AnnapurnaGudditi/ECommerce-SQL-Analysis/issues)
3. **Submit Queries:** Add new analytical queries following the existing structure
4. **Improve Documentation:** Help enhance README and guides

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 📄 License

This project is licensed under the **MIT License** - see the LICENSE file for details.

---

## 🎓 Learning Outcomes

After completing this project, you'll understand:
- ✅ Database design with relationships and constraints
- ✅ Writing efficient SELECT queries
- ✅ Aggregating and grouping data meaningfully
- ✅ Joining multiple tables
- ✅ Using advanced features like CTEs and window functions
- ✅ Analyzing business metrics from raw data
- ✅ Query optimization and best practices

---

## 📞 Support & Questions

- 📧 **Email:** [Your Email]
- 🐙 **GitHub Issues:** [AnnapurnaGudditi/ECommerce-SQL-Analysis/issues](https://github.com/AnnapurnaGudditi/ECommerce-SQL-Analysis/issues)
- 💬 **Discussions:** [Project Discussions](https://github.com/AnnapurnaGudditi/ECommerce-SQL-Analysis/discussions)

---

## ⭐ Show Your Support

If this project helped you learn SQL or served as a reference, please consider:
- ⭐ Starring the repository
- 🔗 Sharing with others
- 📝 Leaving feedback in discussions
- 🤝 Contributing improvements

---

## 🙏 Acknowledgments

- E-commerce sample dataset inspired by real-world scenarios
- SQL best practices from industry standards
- Community feedback and contributions

---

**Created with ❤️ for SQL learners and data enthusiasts**

*Last Updated: 2026-05-25*
