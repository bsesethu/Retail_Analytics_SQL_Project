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