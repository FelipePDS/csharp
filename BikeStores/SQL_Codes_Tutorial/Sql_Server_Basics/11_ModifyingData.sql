-- https://www.sqlservertutorial.net/



----- MODIFYING DATA -----

USE BikeStores;
GO

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