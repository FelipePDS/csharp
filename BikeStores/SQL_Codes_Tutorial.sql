-- https://www.sqlservertutorial.net/




USE BikeStores;
GO

-- SELECT

SELECT
	city,
	COUNT (*)
FROM 
	sales.customers
WHERE
	state = 'CA'
GROUP BY
	city
HAVING
	COUNT (*) > 10
ORDER BY
	city;


-- ORDER BY

SELECT
	city,
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	city DESC,
	first_name ASC;



SELECT
	city,
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	LEN(first_name);



SELECT
	city,
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	2;



-- OFFSET AND FETCH

SELECT
	product_name,
	list_price
FROM
	production.products
ORDER BY
	list_price,
	product_name
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;



SELECT
	product_name,
	list_price
FROM
	production.products
ORDER BY
	list_price,
	product_name
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;



-- TOP

SELECT TOP 10
	product_name,
	list_price
FROM
	production.products
ORDER BY
	list_price DESC;



SELECT TOP 1 PERCENT
	product_name,
	list_price
FROM
	production.products
ORDER BY
	list_price DESC;



SELECT TOP 3 WITH TIES
	product_name,
	list_price
FROM
	production.products
ORDER BY
	list_price DESC;



-- DISTINCT

SELECT DISTINCT
	city
FROM
	sales.customers
ORDER BY 
	city;



SELECT DISTINCT
    city,
    state
FROM
    sales.customers;



SELECT DISTINCT COUNT (*)
	phone
FROM
	sales.customers
ORDER BY
	phone;




-- WHERE

SELECT
	product_id,
	product_name,
	category_id,
	model_year,
	list_price
FROM
	production.products
WHERE
	category_id = 1
ORDER BY
	list_price DESC;




SELECT
	product_id,
	product_name,
	category_id,
	model_year,
	list_price
FROM
	production.products
WHERE
	category_id = 1 AND model_year = 2018;



SELECT
	product_id,
	product_name,
	category_id,
	model_year,
	list_price
FROM
	production.products
WHERE
	list_price > 300 AND model_year = 2018
ORDER BY
	list_price DESC;




SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
	list_price > 300 OR model_year = 2018
ORDER BY
	list_price;



SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
	list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
	list_price;


SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
	list_price IN (299.99, 369.99, 489.99)
ORDER BY
	list_price DESC;



SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
	product_name LIKE '%Cruiser%'
ORDER BY
	list_price DESC;





-- IN

SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price IN (89.99, 109.99, 159.99) -- => list_price = 89.99 OR list_price = 109.99 OR list_price = 159.99
ORDER BY
	list_price;



SELECT
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY
	list_price;




SELECT 
	product_name,
	list_price
FROM
	production.products
WHERE
	product_id IN (
		SELECT
			product_id
		FROM
			production.stocks
		WHERE
			store_id = 1 AND quantity >= 30
	)





-- BETWEEN

SELECT 
	product_id,
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price BETWEEN 149.99 AND 199.99
ORDER BY
	list_price;




SELECT
	product_id,
	product_name,
	list_price
FROM
	production.products
WHERE
	list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY 
	list_price;




SELECT
	order_id,
	customer_id,
	order_date,
	order_status
FROM 
	sales.orders
WHERE
	order_date BETWEEN '20170115' AND '20170117'
ORDER BY
	order_date;




-- LIKE

SELECT
	customer_id,
	first_name,
	last_name
FROM
	sales.customers
WHERE
	last_name LIKE 'z%'
ORDER BY last_name;




SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name LIKE 't%s'
ORDER BY last_name;




SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name LIKE '__u%'
ORDER BY
	last_name;





SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name LIKE '[YZ]%'
ORDER BY 
	last_name;




SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name LIKE '[A-C]%'
ORDER BY
	last_name;




SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name LIKE '[^A-X]%'
ORDER BY
	last_name;




SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
	last_name NOT LIKE 'A%'
ORDER BY
	last_name;




SELECT
	feedback_id,
	comments
FROM
	sales.feedback
WHERE
	comments LIKE '%30!%%' ESCAPE '!';





-- COLUMN & TABLE ALIAS

SELECT
	first_name + ' ' + last_name
FROM
	sales.customers
ORDER BY
	first_name;



SELECT
	first_name + ' ' + last_name AS 'Full Name'
FROM
	sales.customers
ORDER BY	
	first_name;


SELECT
	category_name AS 'Product Category'
FROM
	production.categories;




SELECT
    category_name 'Product Category'
FROM
    production.categories
ORDER BY
    'Product Category';




SELECT
	sales.customers.customer_id,
	first_name,
	last_name,
	order_id
FROM
	sales.customers
INNER JOIN sales.orders ON sales.orders.customer_id = sales.customers.customer_id;

-- QUERY ABOVE USING THE ALIAS

SELECT
	c.customer_id,
	first_name,
	last_name,
	order_id
FROM
	sales.customers c
INNER JOIN sales.orders o ON o.customer_id = c.customer_id;




-- JOINS

SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname emplyee_name
FROM
	hr.candidates c
	INNER JOIN hr.employees e
		ON e.fullname = c.fullname;



SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
		ON e.fullname = c.fullname;



SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM
	hr.candidates c
	LEFT JOIN hr.employees e
		ON e.fullname = c.fullname
WHERE
	e.id IS NULL;




SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM
	hr.candidates c
	RIGHT JOIN hr.employees e
		ON e.fullname = c.fullname;




SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM
	hr.candidates c
	RIGHT JOIN hr.employees e
		ON e.fullname = c.fullname
WHERE
	c.id IS NULL;




SELECT
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM
	hr.candidates c
	FULL JOIN hr.employees e
		ON e.fullname = c.fullname;





-- INNER JOIN

SELECT
	p.product_name,
	c.category_name,
	p.list_price
FROM
	production.products p
	INNER JOIN production.categories c
		ON c.category_id = p.category_id
ORDER BY
	p.product_name DESC;




SELECT
	p.product_name,
	c.category_name,
	b.brand_name,
	p.list_price
FROM
	production.products p
INNER JOIN production.categories c
	ON c.category_id = p.category_id
INNER JOIN production.brands b
	ON b.brand_id = p.brand_id
ORDER BY
	p.product_name DESC;



-- LEFT JOIN

SELECT
	product_name,
	order_id
FROM 
	production.products p
	LEFT JOIN sales.order_items o
		ON o.product_id = p.product_id
ORDER BY
	order_id;




SELECT
	product_name,
	order_id
FROM
	production.products p
	LEFT JOIN sales.order_items o
		ON o.product_id = p.product_id
WHERE
	o.product_id IS NULL
ORDER BY
	product_name;





SELECT
	p.product_name,
	o.order_id,
	i.item_id,
	o.order_date
FROM 
	production.products p
	LEFT JOIN sales.order_items i
		ON i.product_id = p.product_id
	LEFT JOIN sales.orders o
		ON o.order_id = i.order_id
ORDER BY
	o.order_id;




SELECT
	product_name,
	order_id
FROM 
	production.products p
	LEFT JOIN sales.order_items o
		ON o.product_id = p.product_id
WHERE
	order_id = 100
ORDER BY
	product_name;



SELECT
	product_name,
	order_id
FROM
	production.products p
	LEFT JOIN sales.order_items o
		ON o.product_id = p.product_id
		AND o.order_id = 100
ORDER BY
	o.order_id DESC;




-- RIGHT JOIN

SELECT
	product_name,
	order_id
FROM
	sales.order_items o
	RIGHT JOIN production.products p
		ON o.product_id = p.product_id
ORDER BY
	order_id;



SELECT
	product_name,
	order_id
FROM
	sales.order_items o
	RIGHT JOIN production.products p
		ON o.product_id = p.product_id
WHERE
	order_id IS NULL
ORDER BY
	product_name;





-- FULL OUTER JOIN

SELECT
	m.name member,
	p.title project
FROM
	pm.members m
	FULL OUTER JOIN pm.projects p
		ON p.id = m.project_id;




SELECT
	m.name member,
	p.title project
FROM
	pm.members m
	FULL OUTER JOIN pm.projects p
		ON p.id = m.project_id
WHERE
	p.id IS NULL OR
	m.id IS NULL;




-- CROSS JOIN

SELECT
	product_id,
	product_name,
	store_id,
	0 AS quantity
FROM production.products
	CROSS JOIN sales.stores
ORDER BY
	product_name,
	store_id;






SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) sales
FROM
    sales.stores s
CROSS JOIN production.products p
LEFT JOIN (
	SELECT 
		s.store_id,
		p.product_id,
		SUM (quantity * i.list_price) sales
	FROM
		sales.orders o
	INNER JOIN sales.order_items i ON i.order_id = o.order_id
	INNER JOIN sales.stores s ON s.store_id = o.store_id
	INNER JOIN production.products p ON p.product_id = i.product_id
	GROUP BY
		s.store_id,
		p.product_id
) c ON s.store_id = c.store_id
AND p.product_id = c.product_id
WHERE
	sales IS NULL
ORDER BY
	product_id,
	store_id;




-- SELF JOIN

SELECT
	e.first_name + ' ' + e.last_name employee,
	m.first_name + ' ' + m.last_name manager
FROM
	sales.staffs e
	INNER JOIN sales.staffs m 
		ON m.staff_id = e.manager_id
ORDER BY
	manager;




SELECT
	e.first_name + ' ' + e.last_name employee,
	m.first_name + ' ' + m.last_name manager
FROM
	sales.staffs e
	LEFT JOIN sales.staffs m
		ON m.staff_id = e.manager_id
ORDER BY
	manager;




SELECT
	c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
	c2.first_name + ' ' + c2.last_name customer_2
FROM
	sales.customers c1
	INNER JOIN sales.customers c2
		ON c1.customer_id > c2.customer_id
		AND c1.city = c2.city
ORDER BY
	city,
	customer_1,
	customer_2;




SELECT
	c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
	c2.first_name + ' ' + c2.last_name customer_2
FROM
	sales.customers c1
	INNER JOIN sales.customers c2
		ON c2.customer_id <> c1.customer_id
		AND c1.city = c2.city
ORDER BY
	city,
	customer_1,
	customer_2;



SELECT
	c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
	c2.first_name + ' ' + c2.last_name customer_2
FROM
	sales.customers c1
	INNER JOIN sales.customers c2
		ON c2.customer_id > c1.customer_id
		AND c1.city = c2.city
WHERE
	c1.city = 'Albany'
ORDER BY
	c1.city,
	customer_1,
	customer_2;





SELECT
	c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
	c2.first_name + ' ' + c2.last_name customer_2
FROM
	sales.customers c1
	INNER JOIN sales.customers c2
		ON c2.customer_id <> c1.customer_id
		AND c1.city = c2.city
WHERE
	c1.city = 'Albany'
ORDER BY
	c1.city,
	customer_1,
	customer_2;












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









-- UNION

SELECT
	first_name,
	last_name
FROM
	sales.staffs
UNION
SELECT
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	first_name,
	last_name;





SELECT
	first_name,
	last_name
FROM
	sales.staffs
UNION ALL
SELECT
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	first_name,
	last_name;











-- INTERSECT

SELECT
	city
FROM
	sales.customers
INTERSECT
SELECT
	city
FROM
	sales.stores
ORDER BY
	city;






-- EXCEPT

SELECT
	product_id
FROM
	production.products
EXCEPT
SELECT
	product_id
FROM
	sales.order_items;





SELECT
	product_id
FROM
	production.products
EXCEPT
SELECT
	product_id
FROM
	sales.order_items
ORDER BY
	product_id;







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








-- PIVOTS

SELECT 
	* 
FROM (
	SELECT	
		category_name,
		product_id
	FROM
		production.products p
		INNER JOIN production.categories c
			ON c.category_id = p.category_id
) t
PIVOT (
	COUNT (product_id)
	FOR category_name IN (
		[Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes]
	)
) AS pivot_table;






SELECT
	*
FROM (
	SELECT
		category_name,
		product_id,
		model_year
	FROM
		production.products p
		INNER JOIN production.categories c
			ON c.category_id = p.category_id
) t
PIVOT (
	COUNT (product_id)
	FOR category_name IN (
		[Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes]
	)
) AS pivot_table
ORDER BY
	model_year;





-- GET CATEGORIES COLUMNS NAME:

DECLARE
	@columns NVARCHAR(MAX) = '',
	@sql NVARCHAR(MAX) = '';

SELECT
	@columns += QUOTENAME(category_name) + ','
FROM
	production.categories
ORDER BY
	category_name;

SET @columns = LEFT(@columns, LEN(@columns) - 1);

SET @sql = '
	SELECT * FROM
	(
		SELECT
			category_name,
			product_id,
			model_year
		FROM
			production.products p
			INNER JOIN production.categories c
				ON c.category_id = p.category_id
	) t
	PIVOT (
		COUNT (product_id)
		FOR category_name IN ('+ @columns +')
	) AS pivot_table
';

EXECUTE sp_executesql @sql;







-- INSERT INTO

INSERT INTO sales.promotions (
	promotion_name,
	discount,
	start_date,
	expired_date
)
VALUES
	(
		'2018 Summer Promotion',
		0.15,
		'20180601',
		'20180901'
	);





INSERT INTO sales.promotions (
	promotion_name,
	discount,
	start_date,
	expired_date
) OUTPUT inserted.promotion_id
VALUES
	(
		'2018 Fall Promotion',
        0.15,
        '20181001',
        '20181101'
	);






INSERT INTO sales.promotions (
	promotion_name,
	discount,
	start_date,
	expired_date
) 
OUTPUT
	inserted.promotion_id,
	inserted.promotion_name,
	inserted.start_date,
	inserted.expired_date
VALUES (
	'2018 Winter Promotion',
    .2,
    '20181201',
    '20190101'
);






SET IDENTITY_INSERT sales.promotions ON;

INSERT INTO sales.promotions (
	promotion_id,
	promotion_name,
	discount,
	start_date,
	expired_date
) OUTPUT inserted.promotion_id
VALUES (
	4,
    '2019 Spring Promotion',
    0.25,
    '20190201',
    '20190301'
);

SET IDENTITY_INSERT sales.promotions OFF;






-- INSERT MULTIPLE ROWS

INSERT INTO sales.promotions (
	promotion_name,
	discount,
	start_date,
	expired_date
) 
VALUES
	(
        '2019 Summer Promotion',
        0.15,
        '20190601',
        '20190901'
    ),
    (
        '2019 Fall Promotion',
        0.20,
        '20191001',
        '20191101'
    ),
    (
        '2019 Winter Promotion',
        0.25,
        '20191201',
        '20200101'
    );






INSERT INTO sales.promotions (
	promotion_name, discount, start_date, expired_date
) OUTPUT inserted.promotion_id
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');




-- INSERT INTO SELECT

INSERT INTO sales.address (street, city, state, zip_code)
SELECT
	street,
	city,
	state,
	zip_code
FROM
	sales.customers
ORDER BY
	first_name,
	last_name;





INSERT INTO
	sales.address (street, city, state, zip_code)
SELECT
	street,
	city,
	state,
	zip_code
FROM
	sales.stores
WHERE
	city IN ('Santa Cruz', 'Baldwin');





INSERT TOP (10)
INTO sales.address (street, city, state, zip_code)
SELECT
	street,
	city,
	state,
	zip_code
FROM
	sales.customers
ORDER BY
	first_name,
	last_name;





INSERT TOP (10) PERCENT
INTO sales.address (street, city, state, zip_code)
SELECT
	street,
	city,
	state,
	zip_code
FROM
	sales.customers
ORDER BY
	first_name,
	last_name;







-- UPDATE

UPDATE sales.taxes
SET updated_at = GETDATE();





UPDATE sales.taxes
SET
	max_local_tax_rate += 0.02,
	avg_local_tax_rate += 0.01
WHERE
	max_local_tax_rate = 0.01;







-- UPDATE JOIN

UPDATE
	sales.commisions
SET
	sales.commisions.commission = 
		c.base_amount * t.percentage
FROM
	sales.commisions c
	INNER JOIN sales.targets t
		ON t.target_id = c.target_id;







UPDATE
	sales.commisions
SET
	sales.commisions.commission =
		c.base_amount * COALESCE(t.percentage, 0.1)
FROM
	sales.commisions c
	LEFT JOIN sales.targets t
		ON c.target_id = t.target_id;








-- DELETE

DELETE 
	TOP (21)
FROM 
	production.product_history;





DELETE 
	TOP (5) PERCENT
FROM 
	production.product_history;




DELETE
FROM	
	production.product_history
WHERE
	model_year = 2017;





DELETE FROM production.product_history; -- => TRUNCATE TABLE IS MORE EFFICIENT







-- MERGE

MERGE sales.category t
	USING sales.category_staging s
ON (t.category_id = s.category_id)
WHEN MATCHED
	THEN UPDATE SET
		t.category_name = s.category_name,
		t.amount = s.amount
WHEN NOT MATCHED BY TARGET
	THEN INSERT (category_id, category_name, amount)
		VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;








-- CREATE DATABASE

CREATE DATABASE TestDb;





SELECT
	name
FROM
	master.sys.databases
ORDER BY
	name;

-- or

EXEC sp_databases;





-- DROP DATABASE

DROP DATABASE IF EXISTS TestDb;






-- CREATE SCHEMA

CREATE SCHEMA customer_services;
GO




SELECT
	s.name AS schema_name,
	u.name AS schema_owner
FROM
	sys.schemas s
	INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY
	s.name;





CREATE TABLE customer_services.jobs (
	job_id INT PRIMARY KEY IDENTITY,
	customer_id INT NOT NULL,
	description VARCHAR(200),
	created_at DATETIME2 NOT NULL
);







-- ALTER SCHEMA

CREATE PROC usp_get_office_by_id(
	@id INT
) AS
BEGIN
	SELECT
		*
	FROM
		dbo.offices
	WHERE
		office_id = @id;
END;




ALTER SCHEMA sales TRANSFER OBJECT::dbo.offices;





ALTER PROC usp_get_office_by_id(
	@id INT
) AS
BEGIN
	SELECT
		*
	FROM
		sales.offices
	WHERE
		office_id = @id;
END;





-- DROP SCHEMA

CREATE SCHEMA logistics;
GO

CREATE TABLE logistics.deliveries
(
	order_id INT PRIMARY KEY,
	delivery_date DATE NOT NULL,
	delivery_status TINYINT NOT NULL
);

DROP SCHEMA logistics; -- => ERROR

-- SOLUTION:

DROP TABLE logistics.deliveries;

DROP SCHEMA IF EXISTS logistics;





-- CREATE TABLE

CREATE TABLE sales.visits (
	visit_id INT PRIMARY KEY IDENTITY (1, 1),
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	visited_at DATETIME,
	phone VARCHAR(20),
	store_id INT NOT NULL,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);





-- IDENTITY COLUMN

CREATE SCHEMA hr;

CREATE TABLE hr.person (
	person_id INT PRIMARY KEY IDENTITY (1, 1),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL
);

INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('John', 'Doe', 'M');

INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('Jane', 'Dow', 'F');




-- Reusing of identity values

CREATE TABLE hr.position (
	position_id INT PRIMARY KEY IDENTITY (1, 1),
	position_name VARCHAR(255) NOT NULL
);

CREATE TABLE hr.person_position (
	person_id INT,
	position_id INT,
	PRIMARY KEY (person_id, position_id),
	FOREIGN KEY (person_id) REFERENCES hr.person (person_id),
	FOREIGN KEY (position_id) REFERENCES hr.position (position_id)
);


BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO hr.person (first_name, last_name, gender)
		VALUES ('Joan', 'Smith', 'F') -- SUCESS

		INSERT INTO hr.person_position (person_id, position_id)
		VALUES (@@IDENTITY, 1) -- FAIL
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;
GO


INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('Peter','Drucker','F');








-- SEQUENCE

CREATE SEQUENCE item_counter
	AS INT
	START WITH 10
	INCREMENT BY 10;


SELECT NEXT VALUE FOR item_counter;

SELECT NEXT VALUE FOR item_counter;




CREATE SCHEMA procurement;
GO

CREATE TABLE procurement.purchase_orders (
	order_id INT PRIMARY KEY,
	vendor_id INT NOT NULL,
	order_date DATE NOT NULL
);




CREATE SEQUENCE procurement.order_number
	AS INT
	START WITH 1
	INCREMENT BY 1;



INSERT INTO procurement.purchase_orders
(
	order_id, 
	vendor_id, 
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 1, '2019-04-30');


INSERT INTO procurement.purchase_orders
(
	order_id,
	vendor_id,
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 2, '2019-05-01');


INSERT INTO procurement.purchase_orders
(
	order_id,
	vendor_id,
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 3, '2019-05-02');


SELECT
	order_id,
	vendor_id,
	order_date
FROM
	procurement.purchase_orders;






CREATE SEQUENCE procurement.receipt_no
	START WITH 1
	INCREMENT BY 1;


CREATE TABLE procurement.good_receipts
(
	receipt_id INT PRIMARY KEY
		DEFAULT (NEXT VALUE FOR procurement.receipt_no),
	order_id INT NOT NULL,
	full_receipt BIT NOT NULL,
	receipt_date DATE NOT NULL,
	note VARCHAR(100)
);


CREATE TABLE procurement.invoice_receipts
(
	receipt_id INT PRIMARY KEY
		DEFAULT (NEXT VALUE FOR procurement.receipt_no),
	order_id INT NOT NULL,
	is_late BIT NOT NULL,
	receipt_date DATE NOT NULL,
	note NVARCHAR(100)
);


INSERT INTO procurement.good_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    1,
    '2019-05-12',
    'Goods receipt completed at warehouse'
);
INSERT INTO procurement.good_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-12',
    'Goods receipt has not completed at warehouse'
);

INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-13',
    'Invoice duly received'
);
INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    2,
    0,
    '2019-05-15',
    'Invoice duly received'
);



SELECT * FROM procurement.good_receipts;
SELECT * FROM procurement.invoice_receipts;


SELECT
	*
FROM
	sys.sequences;







-- ALTER TABLE ADD COLUMNS

