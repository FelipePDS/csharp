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


