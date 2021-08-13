-- https://www.sqlservertutorial.net/



----- GROUPING DATA -----

USE BikeStores;
GO

-- GROUP BY

SELECT
	customer_id,
	YEAR (order_date) order_year
FROM
	sales.orders
WHERE
	customer_id IN (1, 2)
ORDER BY
	customer_id;

-- QUERY ABOVE WITH GROUP BY

SELECT
	customer_id,
	YEAR (order_date) order_year,
	COUNT (order_id) order_placed
FROM
	sales.orders
WHERE
	customer_id IN (1, 2)
GROUP BY
	customer_id,
	YEAR (order_date)
ORDER BY
	customer_id;






SELECT
	city,
	COUNT (customer_id) customer_count
FROM
	sales.customers
GROUP BY
	city
ORDER BY
	customer_count DESC;




SELECT
	city,
	state,
	COUNT (customer_id) customer_count
FROM
	sales.customers
GROUP BY
	city,
	state
ORDER BY
	state;





SELECT
	brand_name,
	COUNT (brand_name) total_products,
	MIN (list_price) min_price,
	MAX (list_price) max_price
FROM 
	production.products p
INNER JOIN
	production.brands b
		ON b.brand_id = p.brand_id
WHERE
	model_year = 2018
GROUP BY
	brand_name
ORDER BY
	brand_name;




SELECT
	brand_name,
	AVG (list_price) avg_price
FROM
	production.products p
	INNER JOIN production.brands b
		ON b.brand_id = p.brand_id
GROUP BY
	brand_name
ORDER BY
	brand_name;








SELECT
	order_id,
	SUM (
		list_price * quantity * (1 - discount)
	) net_value
FROM
	sales.order_items
GROUP BY
	order_id;







-- HAVING

SELECT
	o.customer_id,
	c.first_name + ' ' + c.last_name customer_name,
	YEAR (order_date) order_year,
	COUNT (order_id) order_count
FROM
	sales.orders o
	INNER JOIN sales.customers c
		ON c.customer_id = o.customer_id
GROUP BY
	o.customer_id,
	YEAR (order_date),
	c.first_name + ' ' + c.last_name
HAVING
	COUNT (order_id) >= 2
ORDER BY
	o.customer_id;






SELECT
	order_id,
	SUM (
		list_price * quantity * (1 - discount)
	) net_value
FROM
	sales.order_items
GROUP BY
	order_id
HAVING (
	SUM (
		list_price * quantity * (1 - discount)
	) > 20000
)
ORDER BY
	net_value;




SELECT
	category_id,
	MIN (list_price) min_price,
	MAX (list_price) max_price
FROM
	production.products
GROUP BY
	category_id
HAVING 
	MAX (list_price) > 4000 OR MIN (list_price) < 500;





SELECT
	category_id,
	AVG (list_price) avg_price
FROM
	production.products
GROUP BY
	category_id
HAVING
	AVG (list_price) BETWEEN 500 AND 1000;







-- GROUPING SETS

SELECT
	b.brand_name AS brand,
	c.category_name AS category,
	p.model_year,
	ROUND (
		SUM (
			quantity * i.list_price * (1 - discount)
		),
		0
	) sales INTO sales.sales_summary
FROM
	sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
	b.brand_name,
	c.category_name,
	p.model_year
ORDER BY
	b.brand_name,
	c.category_name,
	p.model_year;






SELECT
	brand,
	category,
	COUNT (brand) number_years,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	brand,
	category
ORDER BY
	brand,
	category;






SELECT
	brand,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	brand
ORDER BY
	brand;





SELECT
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	category
ORDER BY
	category;






SELECT
	SUM (sales) sales
FROM sales.sales_summary;






SELECT
	brand,
	category,
	SUM (sales) sales
FROM sales.sales_summary
GROUP BY
	brand,
	category
UNION ALL
SELECT
	brand,
	NULL,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	brand
UNION ALL
SELECT
	NULL,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	category
UNION ALL
SELECT
	NULL,
	NULL,
	SUM (sales) sales
FROM
	sales.sales_summary
ORDER BY 
	brand, 
	category;









SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY 
	GROUPING SETS (
		(brand, category),
		(brand),
		(category),
		()
	)
ORDER BY
	brand,
	category;






-- CUBE

SELECT
	brand,
	category,
	SUM (sales) sales
FROM 
	sales.sales_summary
GROUP BY
	CUBE (brand, category)
ORDER BY
	brand,
	category;




SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	brand,
	CUBE (category);




-- ROLLUP

SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	ROLLUP (brand, category)
ORDER BY
	brand,
	category;




SELECT
	category,
	brand,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	ROLLUP (category, brand)
ORDER BY
	brand,
	category;




SELECT
	brand,
	category,
	SUM (sales) sales
FROM
	sales.sales_summary
GROUP BY
	brand,
	ROLLUP (category)
ORDER BY
	brand,
	category;