-- https://www.sqlservertutorial.net/



----- SET OPERATORS -----

USE BikeStores;
GO

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