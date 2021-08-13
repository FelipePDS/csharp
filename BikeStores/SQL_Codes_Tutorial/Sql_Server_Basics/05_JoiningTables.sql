-- https://www.sqlservertutorial.net/



----- JOINING TABLES -----

USE BikeStores;
GO

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