-- https://www.sqlservertutorial.net/



----- FILTERING DATA -----

USE BikeStores;
GO

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