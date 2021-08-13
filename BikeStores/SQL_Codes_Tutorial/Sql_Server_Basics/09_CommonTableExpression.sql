-- https://www.sqlservertutorial.net/



----- COMMON TABLE EXPRESSION (CTE) -----

USE BikeStores;
GO

-- CTE

WITH cte_sales_amount (staff, sales, year) AS (
	SELECT
		first_name + ' ' + last_name,
		SUM(quantity * list_price * (1 - discount)),
		YEAR(order_date)
	FROM
		sales.orders o
		INNER JOIN sales.order_items i
			ON i.order_id = o.order_id
		INNER JOIN sales.staffs s
			ON s.staff_id = o.staff_id
	GROUP BY
		first_name + ' ' + last_name,
		YEAR(order_date)
)

SELECT
	staff,
	sales
FROM
	cte_sales_amount
WHERE
	year = 2018;










WITH cte_sales AS (
	SELECT
		staff_id,
		COUNT (*) order_count
	FROM
		sales.orders
	WHERE
		YEAR(order_date) = 2018
	GROUP BY
		staff_id
)

SELECT
	AVG(order_count) average_orders_by_staff
FROM
	cte_sales;







WITH cte_categories_counts (
	category_id,
	category_name,
	product_count
)
AS (
	SELECT
		c.category_id,
		c.category_name,
		COUNT(p.product_id)
	FROM
		production.products p
		INNER JOIN	production.categories c
			ON c.category_id = p.category_id
	GROUP BY
		c.category_id,
		c.category_name
),
cte_category_sales(category_id, sales) AS (
	SELECT 
		p.category_id,
		SUM (i.quantity * i.list_price * (1 - discount))
	FROM
		sales.order_items i
		INNER JOIN production.products p
			ON p.product_id = i.product_id
		INNER JOIN sales.orders o
			ON o.order_id = i.order_id
	GROUP BY
		p.category_id
)

SELECT
	c.category_id,
	c.category_name,
	c.product_count,
	s.sales
FROM
	cte_categories_counts c
	INNER JOIN cte_category_sales s
		ON s.category_id = c.category_id
ORDER BY
	c.category_name;








-- RECURSIVE CTE

WITH cte_numbers (n, weekday) AS (
	SELECT
		0,
		DATENAME(DW, 0)
	UNION ALL
	SELECT
		n + 1,
		DATENAME(DW, n + 1)
	FROM
		cte_numbers
	WHERE
		n < 6
)

SELECT
	weekday
FROM cte_numbers;









WITH cte_org AS (
	SELECT
		staff_id,
		first_name,
		manager_id
	FROM
		sales.staffs
	WHERE
		manager_id IS NULL
	UNION ALL
	SELECT
		e.staff_id,
		e.first_name,
		e.manager_id
	FROM
		sales.staffs e
		INNER JOIN cte_org o
			ON o.staff_id = e.manager_id
)
SELECT * FROM cte_org;