-- https://www.sqlservertutorial.net/



----- LIMITING ROWS -----

USE BikeStores;
GO

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