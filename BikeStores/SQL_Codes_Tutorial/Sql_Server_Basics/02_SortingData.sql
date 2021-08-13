-- https://www.sqlservertutorial.net/



----- SORTING DATA -----

USE BikeStores;
GO

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