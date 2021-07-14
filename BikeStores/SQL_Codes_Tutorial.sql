-- https://www.sqlservertutorial.net/




USE BikeStores;

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