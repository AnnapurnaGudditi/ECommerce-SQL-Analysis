CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

# Create Customers Table
CREATE TABLE customers (
     customer_id INT PRIMARY KEY,
     customer_name VARCHAR(100),
     email VARCHAR(100),
     city VARCHAR(50),
     state VARCHAR(50),
     registration_date DATE
 );   
 
 # Create Products Table
 CREATE TABLE products (
     product_id INT PRIMARY KEY,
     product_name VARCHAR(100),
     category VARCHAR(50),
     price DECIMAL(10,2),
     stock_quantity INT
 );    
 
 # Create Orders Table
 CREATE TABLE orders (
     order_id INT PRIMARY KEY,
     customer_id INT,
     order_date DATE,
     total_amount DECIMAL(10,2),
     status VARCHAR(20),
     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
 );    
 
 # Create Order Items Table
 CREATE TABLE order_items (
     item_id INT PRIMARY KEY,
     order_id INT,
     product_id INT,
     quantity INT,
     unit_price DECIMAL(10,2),
     FOREIGN KEY (order_id) REFERENCES orders(order_id),
     FOREIGN KEY (product_id) REFERENCES products(product_id)
 );    
 
 # Inserting data into Customers Table
 INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Hyderabad', 'Telangana', '2022-01-15'),
(2, 'Priya Reddy', 'priya@gmail.com', 'Bangalore', 'Karnataka', '2022-02-20'),
(3, 'Amit Kumar', 'amit@gmail.com', 'Mumbai', 'Maharashtra', '2022-03-10'),
(4, 'Sneha Patel', 'sneha@gmail.com', 'Chennai', 'Tamil Nadu', '2022-04-05'),
(5, 'Vikram Singh', 'vikram@gmail.com', 'Delhi', 'Delhi', '2022-05-12'),
(6, 'Ananya Iyer', 'ananya@gmail.com', 'Hyderabad', 'Telangana', '2022-06-18'),
(7, 'Ravi Verma', 'ravi@gmail.com', 'Pune', 'Maharashtra', '2022-07-22'),
(8, 'Deepa Nair', 'deepa@gmail.com', 'Bangalore', 'Karnataka', '2022-08-30'),
(9, 'Suresh Babu', 'suresh@gmail.com', 'Hyderabad', 'Telangana', '2022-09-14'),
(10, 'Kavya Rao', 'kavya@gmail.com', 'Chennai', 'Tamil Nadu', '2022-10-25');
 
 # Inserting data into products table
 INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000.00, 50),
(2, 'Mobile Phone', 'Electronics', 25000.00, 100),
(3, 'Headphones', 'Electronics', 3000.00, 200),
(4, 'Office Chair', 'Furniture', 8000.00, 30),
(5, 'Study Table', 'Furniture', 12000.00, 20),
(6, 'Python Book', 'Books', 500.00, 150),
(7, 'Data Science Book', 'Books', 750.00, 100),
(8, 'Backpack', 'Accessories', 1500.00, 75),
(9, 'Water Bottle', 'Accessories', 400.00, 300),
(10, 'Desk Lamp', 'Electronics', 1200.00, 80);

# Inserting data into orders table
INSERT INTO orders VALUES
(1, 1, '2023-01-10', 55000.00, 'Delivered'),
(2, 2, '2023-01-15', 25000.00, 'Delivered'),
(3, 3, '2023-02-05', 3000.00, 'Delivered'),
(4, 4, '2023-02-20', 8000.00, 'Cancelled'),
(5, 5, '2023-03-10', 12000.00, 'Delivered'),
(6, 6, '2023-03-25', 500.00, 'Delivered'),
(7, 7, '2023-04-05', 750.00, 'Pending'),
(8, 8, '2023-04-18', 1500.00, 'Delivered'),
(9, 9, '2023-05-02', 55000.00, 'Delivered'),
(10, 10, '2023-05-20', 25000.00, 'Delivered'),
(11, 1, '2023-06-10', 3000.00, 'Delivered'),
(12, 2, '2023-06-25', 1200.00, 'Delivered'),
(13, 3, '2023-07-08', 8000.00, 'Cancelled'),
(14, 4, '2023-07-22', 400.00, 'Delivered'),
(15, 5, '2023-08-05', 12000.00, 'Delivered'),
(16, 6, '2023-08-19', 750.00, 'Delivered'),
(17, 7, '2023-09-01', 500.00, 'Delivered'),
(18, 8, '2023-09-15', 55000.00, 'Pending'),
(19, 9, '2023-10-03', 25000.00, 'Delivered'),
(20, 10, '2023-10-28', 3000.00, 'Delivered');

# Inserting data into order items table
INSERT INTO order_items VALUES
(1, 1, 1, 1, 55000.00),
(2, 2, 2, 1, 25000.00),
(3, 3, 3, 1, 3000.00),
(4, 4, 4, 1, 8000.00),
(5, 5, 5, 1, 12000.00),
(6, 6, 6, 2, 500.00),
(7, 7, 7, 1, 750.00),
(8, 8, 8, 1, 1500.00),
(9, 9, 1, 1, 55000.00),
(10, 10, 2, 1, 25000.00),
(11, 11, 3, 1, 3000.00),
(12, 12, 10, 1, 1200.00),
(13, 13, 4, 1, 8000.00),
(14, 14, 9, 1, 400.00),
(15, 15, 5, 1, 12000.00),
(16, 16, 7, 1, 750.00),
(17, 17, 6, 1, 500.00),
(18, 18, 1, 1, 55000.00),
(19, 19, 2, 1, 25000.00),
(20, 20, 3, 1, 3000.00);



# Q1 Total Number of customers
select count(*) as total_customers from customers;

# Q2 Total number of orders
select count(*) as total_orders from orders;

# Q3 Total Revenue
select sum(total_amount) as total_revenue
from orders
where status = 'Delivered';


# Q4 Orders by status
select status,
       count(*) as total_orders
from orders
group by status
order by total_orders desc;       

# Q5 Top 5 customers by spending
select c.customer_name,
       c.city,
       sum(total_amount) as total_spent
from customers as c
join orders as o on c.customer_id = o.customer_id
where status = 'Delivered'
group by c.customer_id, c.customer_name, c.city
order by total_spent desc
limit 5;       

# Q6 Revenue by City
select c.city,
	   count(o.order_id) as total_orders,
       sum(o.total_amount) as total_revenue
from customers as c
join orders as o on c.customer_id = o.customer_id
where o.status = 'Delivered'
group by c.city
order by total_revenue desc;     


# Q7 Best Selling Products
select p.product_name,
       p.category,
       count(oi.item_id) as times_ordered,
       sum(oi.quantity) as total_quantity_sold
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name, p.category
order by total_quantity_sold desc;


# Q8 Revenue by product category
select p.category,
       count(oi.item_id) as total_orders,
       sum(oi.quantity * oi.unit_price) as category_revenue
 from products p
 join order_items as oi on p.product_id = oi.product_id
 join orders as o on oi.order_id = o.order_id
 where status = 'Delivered'
 group by p.category
 order by category_revenue desc;
 
 
 # Q9 Monthly Revenue
 select month(order_date) as month,
        monthname(order_date) as month_name,
        count(order_id) as total_orders,
        sum(total_amount) as monthly_revenue
 from orders
 where status = 'Delivered'
 group by month(order_date), monthname(order_date)
 order by month;


# Q10 Customers who never ordered
select c.customer_name,
       c.email,
       c.city
 from customers as c
 left join orders as o on c.customer_id = o.customer_id
 where o.order_id is null;
 
 
 # Q11 Average order value by city
 select c.city,
		round(avg(o.total_amount), 2) as avg_order_value
 from customers as c
 join orders as o on c.customer_id = o.customer_id
 where o.status = 'Delivered'
 group by c.city
 order by avg_order_value desc;
 
 
 # Q12 Cancellation Rate by City
 select c.city,
        count(o.order_id) as total_orders,
        sum(case when o.status = 'Cancelled' then 1 else 0 end) as cancelled_orders,
        round(sum(case when o.status = 'Cancelled' then 1 else 0 end) * 100 / count(o.order_id), 2) as cancellation_rate
from customers as c
join orders as o on c.customer_id = o.customer_id
group by c.city
order by cancellation_rate desc;


# Q13 Repeat Orders
select c.customer_name,
	   c.city,
       count(o.order_id) as total_orders
 from customers as c
 join orders as o on c.customer_id = o.customer_id
 group by c.customer_id, c.customer_name, c.city
 having count(o.order_id) > 1
 order by total_orders desc;
 
 
 # Q14 Top Product in each category
 select category,
        product_name,
        total_sold
 from (
     select p.category,
            p.product_name,
            sum(oi.quantity) as total_sold,
            rank() over (partition by p.category
                         order by sum(oi.quantity) desc) as rnk
      from products p
      join order_items as oi on p.product_id = oi.product_id
      group by p.category, p.product_id, p.product_name
 ) as ranked_products
 where rnk = 1;
 
 
 # Q15 Customer Ranking by revenue
 select c.customer_name,
        c.city,
        sum(o.total_amount) as total_spent,
        rank() over (order by sum(o.total_amount) desc) as revenue_rank
from customers as c
join orders as o on c.customer_id = o.customer_id
where o.status = 'Delivered'
group by c.customer_id, c.customer_name, c.city;       


# Q16 Running Total Revenue by month
select monthname(order_date) as month,
       sum(total_amount) as monthly_revenue,
       sum(sum(total_amount)) over (order by month(order_date)) as running_total
 from orders
 where status = 'Delivered'
 group by month(order_date), monthname(order_date)
 order by month(order_date);


# Q17 Products with low stock
select product_name,
       category,
       stock_quantity
 from products
 where stock_quantity < 50
 order by stock_quantity asc;
 
 
 # Q18 Revenue contribution Percentage by category
 select p.category,
        sum(oi.quantity * oi.unit_price) as category_revenue,
		round(
            sum(oi.quantity * oi.unit_price) * 100 /
            sum(sum(oi.quantity * oi.unit_price)) over()
         , 2) as revenue_percentage
 from products as p
 join order_items as oi on p.product_id = oi.product_id
 join orders as o on oi.order_id = o.order_id
 where o.status = 'Delivered'
 group by p.category
 order by category_revenue desc;
 
 
 # Q19 High value customers using CTE
 with customer_revenue as (
    select c.customer_id,
	       c.customer_name,
           c.city,
           sum(o.total_amount) as total_spent
    from customers as c
    join orders as o on c.customer_id = o.customer_id
    where o.status = 'Delivered'
    group by c.customer_id, c.customer_name, c.city
 )
 select customer_name,
        city,
        total_spent
 from customer_revenue
 where total_spent > 50000
 order by total_spent desc;
 
 
 # Q20 Complete business summary
 select
     (select count(*) from customers) as total_customers,
     (select count(*) from orders) as total_orders,
     (select count(*) from orders where status = 'Delivered') as delievered_orders,
     (select count(*) from orders where status = 'Cancelled') as cancelled_orders,
     (select round(sum(total_amount), 2) from orders where status = 'Delivered') as total_revenue,
     (select round(avg(total_amount), 2) from orders where status = 'Delivered') as avg_order_value;