# Retail_Analytics_SQL_Project

🛍️ Retail Analytics SQL Project
Welcome to the Retail Analytics SQL Challenge, where you'll take on the role of a Junior Data Analyst at TechStyle Retail Group. Your job is to extract actionable insights from customer, sales, and product data to help the business drive decisions.

📌 Project Objective
You’ll use your SQL skills to explore customer behavior, sales performance, and inventory health. The project is designed to test your ability to write analytical queries, join multiple tables, calculate KPIs, and identify inconsistencies in data.

🗃️ Dataset Overview
The project simulates a simplified retail e-commerce company and contains four key tables:

CUSTOMERS
Column	Data Type	Description
customer_id	INT (PK)	Unique ID for each customer
name	VARCHAR(100)	Full name of the customer
email	VARCHAR(100)	Email address
gender	VARCHAR(10)	Gender (Male, Female, Other)
registration_date	DATE	Date of account creation
city	VARCHAR(100)	City of residence
country	VARCHAR(100)	Country of residence
PRODUCTS
Column	Data Type	Description
product_id	INT (PK)	Unique product identifier
name	VARCHAR(100)	Product name
category	VARCHAR(50)	Product category
price	DECIMAL(10,2)	Retail price
stock_quantity	INT	Available inventory units
ORDERS
Column	Data Type	Description
order_id	INT (PK)	Unique order identifier
customer_id	INT (FK)	Link to customer
order_date	DATE	Date the order was placed
total_amount	DECIMAL(10,2)	Total amount paid by customer
ORDER_ITEMS
Column	Data Type	Description
order_item_id	INT (PK)	Unique order item ID
order_id	INT (FK)	Link to order
product_id	INT (FK)	Link to product
quantity	INT	Number of units purchased
price	DECIMAL(10,2)	Price at the time of purchase
🧠 Business Questions to Answer
Use SQL to answer the following:

Sales Analysis
What is the monthly revenue trend over the past year?
Which product categories generate the most revenue?
Customer Insights
Who are the top 10 customers by lifetime value?
What percentage of customers made more than one order?
Product Performance
What are the top 5 best-selling products per category?
Which products have high stock but poor sales?
Operational & Data Quality
Are there any orders where total_amount doesn’t match the sum of items?
Identify duplicate emails in the customer table.
✅ Deliverables
Each student/team must submit the following:

A .sql file with all your queries
A summary.md or .pdf with written explanations for your answers
A bonus: A SQL View or Stored Procedure for any custom metric (e.g. CLV)
🔧 Data Generation using Mockaroo
We will use Mockaroo to generate sample data. It’s a powerful tool that allows you to define schemas and generate random data in SQL or CSV format.

How to Generate Your Dataset
Visit https://mockaroo.com
Click “Create Schema”
For each table (CUSTOMERS, PRODUCTS, ORDERS, ORDER_ITEMS), add columns matching the schema above:
Use types like Full Name, Email Address, Row Number, City, Country, Product, Category, Decimal, Date, etc.
For foreign keys:
First generate and export the parent tables (e.g., CUSTOMERS)
Upload them as datasets
In child tables, use Dataset Column to reference the appropriate keys (e.g., customer_id, product_id)
Choose SQL as your export format
Set desired row counts:
Table	Rows
CUSTOMERS	300
PRODUCTS	100
ORDERS	1000
ORDER_ITEMS	2500
Download the generated .sql files and import them into your database
Video Tutorial
Watch this Mockaroo Tutorial for a quick demo on building realistic datasets with mock relationships.

📁 Recommended Project Folder Structure
Organize your SQL project like a real-world data team. This makes your work modular, scalable, and easy to navigate.

retail_analytics_sql_project/
│
├── 📄 README.md                   # Project overview, context, instructions
├── 📁 data/
│   ├── customers.sql             # INSERTs or CSV/SQL data dump
│   ├── products.sql
│   ├── orders.sql
│   ├── order_items.sql
│   └── schema.sql                # All CREATE TABLE statements
│
├── 📁 queries/
│   ├── 01_sales_analysis.sql     # Revenue & category insights
│   ├── 02_customer_insights.sql # CLV, segmentation, repeat rate
│   ├── 03_product_performance.sql
│   ├── 04_data_quality_checks.sql
│   └── 99_bonus_tasks.sql        # KPI view, anomaly checks, stored procs
│
├── 📁 outputs/
│   ├── summary.md                # Answers/explanations
│   └── charts/                   # Optional: screenshots/plots
│
├── 📁 mockaroo_schemas/          # JSON schemas for data generation
│   └── customers-schema.json
│
└── 📁 setup/
    ├── docker-compose.yml        # Optional: for DB setup (MySQL/Postgres)
    └── init.sql                  # Optional: full init script for tables + data
