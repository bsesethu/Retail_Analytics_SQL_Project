-- Sales Analysis
	-- What is the monthly revenue trend over the past year?
SELECT 
	order_month_num,
	order_month,
	order_year,
	SUM(CAST(REPLACE(total_amount, '$', '') AS DECIMAL(10, 2))) sum_month
FROM (
	SELECT 
		*,
		DATEPART(MONTH, order_date) order_month_num,
		DATENAME(MONTH, order_date) order_month,
		DATEPART(YEAR, order_date) order_year
	FROM ORDERS
	WHERE DATEDIFF(DAY, order_date, GETDATE()) <= 365 -- Over the past year
	--ORDER BY order_month -- Can't use ORDER BY Here
	)t
GROUP BY order_month, order_month_num, order_year
ORDER BY order_month_num 

	-- Which product categories generate the most revenue?
SELECT 
	category,
	SUM(revenue) sum_revenue
FROM (
	SELECT *,
		CAST(price as DECIMAL(10, 2)) as price_numVal,
		CAST(stock_quantity as DECIMAL(10, 2)) as stock_numVal,
		(CAST(price as DECIMAL(10, 2)) * CAST(stock_quantity as DECIMAL(10, 2))) revenue
	FROM PRODUCTS
	)c
GROUP BY category
ORDER BY sum_revenue DESC
-------------------------------------------------------------------------------------------------------

-- Customer Insights
	-- Who are the top 10 customers by lifetime value?
SELECT 
	TOP 10
	c.customer_id,
	c.name,
	c.email,
	--o.order_id,
	--o.total_amount,
	SUM(CAST(REPLACE(total_amount, '$', '') as DECIMAL(10, 2))) sum_total
FROM CUSTOMERS c
INNER JOIN ORDERS o -- INNER JOIN because we only want the data where both tables intersect, nothing more
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email
ORDER BY sum_total DESC

	--What percentage of customers made more than one order?
--SELECT * FROM CUSTOMERS c INNER JOIN ORDERS o ON c.customer_id = o.customer_id -- Joined tables
SELECT count_1plus / 200.0 * 100 percnt_of_cust_more_than_one_order
FROM (
	SELECT
		COUNT(*) count_1plus -- No. of rows with more than 1 order per customer
		FROM (
		SELECT 
			c.customer_id,
			COUNT(DISTINCT o.order_id) count_id
		FROM CUSTOMERS c
		INNER JOIN ORDERS o
		ON c.customer_id = o.customer_id
		GROUP BY c.customer_id
		)t
	WHERE count_id > 1
	)s
---------------------------------------------------------------------------------------------------------

-- Product Performance
	--What are the top 5 best-selling products per category?
-- SELECT * FROM PRODUCTS p INNER JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
-- SELECT * FROM ORDER_ITEMS

SELECT TOP 5
	product_id,
	name,
	category,
	SUM(revenue) sum_revenue
FROM (
	SELECT
		p.product_id,
		p.name,
		p.category,
		CAST(oi.quantity as INT) Quantity_int,
		CAST(REPLACE(oi.price, '$', '') as FLOAT) price_float,
		CAST(oi.quantity as INT) * CAST(REPLACE(oi.price, '$', '') as FLOAT) revenue -- quantity * price
	FROM PRODUCTS p 
	INNER JOIN ORDER_ITEMS oi 
	ON p.product_id = oi.product_id
	)p
GROUP BY product_id, name, category
ORDER BY sum_revenue DESC
	
	--Which products have high stock but poor sales?
SELECT TOP 15
	product_id,
	name,
	category,
	quantity_stock,
	SUM(revenue) sum_revenue
FROM (
	SELECT
		p.product_id,
		p.name,
		p.category,
		p.stock_quantity * 50 quantity_stock, -- Make the quanities more resonable
		CAST(oi.quantity as INT) quantity_sold_int,
		CAST(REPLACE(oi.price, '$', '') as FLOAT) price_float,
		CAST(oi.quantity as INT) * CAST(REPLACE(oi.price, '$', '') as FLOAT) revenue -- quantity * price
	FROM PRODUCTS p 
	INNER JOIN ORDER_ITEMS oi 
	ON p.product_id = oi.product_id
	)p
WHERE quantity_stock > 1000 --AND sum_revenue < 1000
GROUP BY product_id, name, category, quantity_stock 
ORDER BY sum_revenue 
-- poor sum_revenue is values below 1000
-- high stock is values above 1300
-- These are bad selling products with a high stock count
-------------------------------------------------------------------------------------------------------------------

-- Operational & Data Quality
	-- Are there any orders where total_amount doesn’t match the sum of items?

	
	
	--Identify duplicate emails in the customer table.
