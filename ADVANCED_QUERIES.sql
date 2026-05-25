-- ========================================
-- ADVANCED SUPPLEMENTARY QUERIES
-- ========================================
-- These queries demonstrate additional advanced SQL techniques
-- and can be added to the main analysis

USE ecommerce_analysis;

-- ========================================
-- A1: Customer Lifetime Value (CLV) Analysis
-- ========================================
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as lifetime_value,
    ROUND(AVG(o.total_amount), 2) as avg_order_value,
    MIN(o.order_date) as first_purchase,
    MAX(o.order_date) as last_purchase,
    DATEDIFF(MAX(o.order_date), MIN(o.order_date)) as days_active
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY lifetime_value DESC;

-- ========================================
-- A2: Product Performance Matrix
-- ========================================
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COUNT(oi.item_id) as times_ordered,
    SUM(oi.quantity) as total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) as total_revenue,
    ROUND((SUM(oi.quantity * oi.unit_price) / (p.stock_quantity + SUM(oi.quantity))) * 100, 2) as revenue_per_unit_available
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price, p.stock_quantity
ORDER BY total_revenue DESC;

-- ========================================
-- A3: Month-over-Month Revenue Growth
-- ========================================
WITH monthly_revenue AS (
    SELECT 
        MONTH(order_date) as month,
        MONTHNAME(order_date) as month_name,
        SUM(total_amount) as monthly_revenue
    FROM orders
    WHERE status = 'Delivered'
    GROUP BY MONTH(order_date), MONTHNAME(order_date)
)
SELECT 
    month,
    month_name,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) as prev_month_revenue,
    ROUND(((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) / 
           LAG(monthly_revenue) OVER (ORDER BY month)) * 100, 2) as growth_percentage
FROM monthly_revenue;

-- ========================================
-- A4: Customer Segmentation by RFM Analysis
-- ========================================
WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.city,
        COUNT(o.order_id) as frequency,
        SUM(o.total_amount) as monetary,
        DATEDIFF(NOW(), MAX(o.order_date)) as recency
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name, c.city
),
rfm_ranking AS (
    SELECT 
        customer_id,
        customer_name,
        city,
        frequency,
        monetary,
        recency,
        NTILE(3) OVER (ORDER BY recency ASC) as r_score,
        NTILE(3) OVER (ORDER BY frequency DESC) as f_score,
        NTILE(3) OVER (ORDER BY monetary DESC) as m_score
    FROM customer_metrics
)
SELECT 
    customer_name,
    city,
    frequency,
    monetary,
    recency,
    CONCAT(r_score, f_score, m_score) as rfm_score,
    CASE 
        WHEN (r_score = 3 AND f_score = 3) THEN 'Best Customers'
        WHEN r_score = 3 THEN 'Recently Active'
        WHEN f_score = 3 THEN 'Loyal Customers'
        WHEN (r_score = 1 OR f_score = 1) THEN 'At Risk'
        ELSE 'Potential'
    END as customer_segment
FROM rfm_ranking
ORDER BY monetary DESC;

-- ========================================
-- A5: Inventory Efficiency Analysis
-- ========================================
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.stock_quantity as current_stock,
    COALESCE(SUM(oi.quantity), 0) as units_sold,
    ROUND(COALESCE(SUM(oi.quantity), 0) / p.stock_quantity * 100, 2) as turnover_rate,
    (p.stock_quantity - COALESCE(SUM(oi.quantity), 0)) as units_remaining
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price, p.stock_quantity
ORDER BY turnover_rate DESC;

-- ========================================
-- A6: Order Value Distribution
-- ========================================
SELECT 
    CASE 
        WHEN total_amount < 5000 THEN 'Low (< 5K)'
        WHEN total_amount BETWEEN 5000 AND 15000 THEN 'Medium (5K-15K)'
        WHEN total_amount BETWEEN 15000 AND 50000 THEN 'High (15K-50K)'
        ELSE 'Very High (> 50K)'
    END as price_segment,
    COUNT(*) as order_count,
    ROUND(AVG(total_amount), 2) as avg_amount,
    MIN(total_amount) as min_amount,
    MAX(total_amount) as max_amount,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM orders), 2) as percentage_of_total
FROM orders
WHERE status = 'Delivered'
GROUP BY price_segment
ORDER BY min_amount;

-- ========================================
-- A7: Geographic Performance Score
-- ========================================
SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) as total_customers,
    COUNT(o.order_id) as total_orders,
    ROUND(SUM(o.total_amount), 2) as total_revenue,
    ROUND(AVG(o.total_amount), 2) as avg_order_value,
    ROUND((COUNT(DISTINCT CASE WHEN o.status = 'Delivered' THEN 1 END) / 
            COUNT(o.order_id)) * 100, 2) as delivery_rate,
    ROUND((SELECT COUNT(*) FROM orders WHERE status = 'Cancelled' 
           AND customer_id IN (SELECT customer_id FROM customers WHERE city = c.city)) / 
           COUNT(o.order_id) * 100, 2) as cancellation_rate
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- ========================================
-- A8: Product Cross-Sell Analysis
-- ========================================
WITH product_orders AS (
    SELECT 
        oi1.product_id as product1,
        oi2.product_id as product2,
        COUNT(*) as frequency
    FROM order_items oi1
    JOIN order_items oi2 ON oi1.order_id = oi2.order_id
    WHERE oi1.product_id < oi2.product_id
    GROUP BY oi1.product_id, oi2.product_id
)
SELECT 
    p1.product_name as product_1,
    p2.product_name as product_2,
    p1.category as category_1,
    p2.category as category_2,
    frequency as times_purchased_together
FROM product_orders
JOIN products p1 ON product1 = p1.product_id
JOIN products p2 ON product2 = p2.product_id
ORDER BY frequency DESC
LIMIT 10;

-- ========================================
-- A9: Sales Velocity Analysis
-- ========================================
WITH daily_sales AS (
    SELECT 
        order_date,
        COUNT(*) as orders,
        SUM(total_amount) as revenue
    FROM orders
    WHERE status = 'Delivered'
    GROUP BY order_date
)
SELECT 
    order_date,
    orders,
    revenue,
    AVG(orders) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as avg_orders_7day,
    AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as avg_revenue_7day
FROM daily_sales
ORDER BY order_date DESC;

-- ========================================
-- A10: Customer Retention Cohort Analysis
-- ========================================
WITH customer_cohorts AS (
    SELECT 
        c.customer_id,
        DATE_TRUNC(MIN(o.order_date), MONTH) as cohort_month,
        COUNT(DISTINCT o.order_id) as order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id
)
SELECT 
    cohort_month,
    COUNT(DISTINCT customer_id) as cohort_size,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) as returning_customers,
    ROUND((SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) / 
            COUNT(DISTINCT customer_id)) * 100, 2) as retention_rate
FROM customer_cohorts
GROUP BY cohort_month
ORDER BY cohort_month DESC;

-- ========================================
-- NOTES ON ADVANCED QUERIES
-- ========================================
-- A1: Customer Lifetime Value - Essential for identifying most valuable customers
-- A2: Product Performance Matrix - Complete product analytics
-- A3: Month-over-Month Growth - Track business momentum and trends
-- A4: RFM Segmentation - Customer segmentation for targeted marketing
-- A5: Inventory Efficiency - Optimize stock levels and procurement
-- A6: Order Value Distribution - Understand customer purchasing power
-- A7: Geographic Performance - Regional performance scorecard
-- A8: Cross-Sell Analysis - Product bundling and recommendations
-- A9: Sales Velocity - Real-time sales performance tracking
-- A10: Cohort Retention - Customer loyalty and repeat purchase patterns

-- Note: Some queries use DATE_TRUNC which may not be available in older MySQL versions.
-- Alternative for MySQL: Use DATE_FORMAT(order_date, '%Y-%m-01') for month truncation
