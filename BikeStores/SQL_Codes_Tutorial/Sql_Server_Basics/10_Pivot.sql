-- https://www.sqlservertutorial.net/



----- PIVOT -----

USE BikeStores;
GO

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