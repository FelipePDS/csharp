-- https://www.sqlservertutorial.net/



----- QUERYING DATA -----

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