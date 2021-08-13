-- https://www.sqlservertutorial.net/



----- SUBQUERY -----

USE BikeStores;
GO

-- SUBQUERY

SELECT
	order_id,
	order_date,
	c.first_name + ' ' + c.last_name customer_name
FROM
	sales.orders o
	INNER JOIN sales.customers c
		ON c.customer_id = o.customer_id
WHERE
	c.city = 'New York'
ORDER BY
	order_date DESC;

-- QUERY ABOVE USING SUBQUERY

SELECT
	order_id,
	order_date,
	customer_id
FROM
	sales.orders
WHERE
	customer_id IN (
		SELECT
			customer_id
		FROM
			sales.customers
		WHERE
			city = 'New York'
	)
ORDER BY
	order_date DESC;







SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price > (
		SELECT
			AVG (list_price)
		FROM
			production.products
		WHERE 
			brand_id IN (
				SELECT
					brand_id
				FROM
					production.brands
				WHERE
					brand_name = 'Strider'
				OR brand_name = 'Trek'
			)
	)
ORDER BY
	list_price;




SELECT
	order_id,
	order_date,
	(
		SELECT	
			MAX (list_price)
		FROM
			sales.order_items i
		WHERE
			i.order_id = o.order_id
	) AS max_list_price
FROM
	sales.orders o
ORDER BY
	order_date DESC;








SELECT
	product_id,
	product_name
FROM
	production.products
WHERE 
	category_id IN (
		SELECT
			category_id
		FROM
			production.categories
		WHERE
			category_name = 'Mountain Bikes'
		OR category_name = 'Road Bikes'
	);






SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price >= ANY (
		SELECT
			AVG (list_price)
		FROM
			production.products
		GROUP BY
			brand_id
	);






SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price >= ALL (
		SELECT	
			AVG (list_price)
		FROM
			production.products
		GROUP BY
			brand_id
	);





SELECT
	customer_id,
	first_name,
	last_name,
	city
FROM
	sales.customers c
WHERE
	EXISTS (
		SELECT
			order_id
		FROM
			sales.orders o
		WHERE
			o.customer_id = c.customer_id
		AND YEAR (order_date) = 2017
	)
ORDER BY
	first_name,
	last_name;







SELECT
	customer_id,
	first_name,
	last_name,
	city
FROM
	sales.customers c
WHERE
	NOT EXISTS (
		SELECT
			order_id
		FROM
			sales.orders o
		WHERE
			o.customer_id = c.customer_id
		AND YEAR (order_date) = 2017
	)
ORDER BY
	first_name,
	last_name;





SELECT
	AVG (order_count) average_order_count_by_staff
FROM
	(
		SELECT	
			staff_id,
			COUNT (order_id) order_count
		FROM
			sales.orders
		GROUP BY
			staff_id
	) t;








-- CORRELATED SUBQUERY

SELECT
	product_name,
	list_price,
	category_id
FROM
	production.products p1
WHERE
	list_price IN (
		SELECT
			MAX (p2.list_price)
		FROM
			production.products p2
		WHERE
			p2.category_id = p1.category_id
		GROUP BY
			p2.category_id
	)
ORDER BY
	category_id,
	product_name;







-- EXISTS / NOT EXISTS

SELECT
	customer_id,
	first_name,
	last_name
FROM
	sales.customers
WHERE
	EXISTS (SELECT NULL)
ORDER BY
	first_name,
	last_name;





SELECT
	customer_id,
	first_name,
	last_name
FROM
	sales.customers c
WHERE
	EXISTS (
		SELECT
			COUNT (*)
		FROM
			sales.orders o
		WHERE
			customer_id = c.customer_id
		GROUP BY
			customer_id
		HAVING
			COUNT (*) > 2
	)
ORDER BY
	first_name,
	last_name;







-- ANY

SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	product_id = ANY (
		SELECT
			product_id
		FROM
			sales.order_items
		WHERE
			quantity >= 2
	)
ORDER BY
	product_name;






-- ALL

SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price > ALL (
		SELECT
			AVG (list_price) avg_list_price
		FROM
			production.products
		GROUP BY
			brand_id
	)
ORDER BY
	list_price;





SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price < ALL (
		SELECT
			AVG (list_price) avg_list_price
		FROM
			production.products
		GROUP BY
			brand_id
	)
ORDER BY
	list_price;