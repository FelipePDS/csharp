-- https://www.sqlservertutorial.net/



----- DATA DEFINITION -----

USE BikeStores;
GO

-- CREATE DATABASE

CREATE DATABASE TestDb;





SELECT
	name
FROM
	master.sys.databases
ORDER BY
	name;

-- or

EXEC sp_databases;





-- DROP DATABASE

DROP DATABASE IF EXISTS TestDb;






-- CREATE SCHEMA

CREATE SCHEMA customer_services;
GO




SELECT
	s.name AS schema_name,
	u.name AS schema_owner
FROM
	sys.schemas s
	INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY
	s.name;





CREATE TABLE customer_services.jobs (
	job_id INT PRIMARY KEY IDENTITY,
	customer_id INT NOT NULL,
	description VARCHAR(200),
	created_at DATETIME2 NOT NULL
);







-- ALTER SCHEMA

CREATE PROC usp_get_office_by_id(
	@id INT
) AS
BEGIN
	SELECT
		*
	FROM
		dbo.offices
	WHERE
		office_id = @id;
END;




ALTER SCHEMA sales TRANSFER OBJECT::dbo.offices;





ALTER PROC usp_get_office_by_id(
	@id INT
) AS
BEGIN
	SELECT
		*
	FROM
		sales.offices
	WHERE
		office_id = @id;
END;





-- DROP SCHEMA

CREATE SCHEMA logistics;
GO

CREATE TABLE logistics.deliveries
(
	order_id INT PRIMARY KEY,
	delivery_date DATE NOT NULL,
	delivery_status TINYINT NOT NULL
);

DROP SCHEMA logistics; -- => ERROR

-- SOLUTION:

DROP TABLE logistics.deliveries;

DROP SCHEMA IF EXISTS logistics;





-- CREATE TABLE

CREATE TABLE sales.visits (
	visit_id INT PRIMARY KEY IDENTITY (1, 1),
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	visited_at DATETIME,
	phone VARCHAR(20),
	store_id INT NOT NULL,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);





-- IDENTITY COLUMN

CREATE SCHEMA hr;

CREATE TABLE hr.person (
	person_id INT PRIMARY KEY IDENTITY (1, 1),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender CHAR(1) NOT NULL
);

INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('John', 'Doe', 'M');

INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('Jane', 'Dow', 'F');




-- Reusing of identity values

CREATE TABLE hr.position (
	position_id INT PRIMARY KEY IDENTITY (1, 1),
	position_name VARCHAR(255) NOT NULL
);

CREATE TABLE hr.person_position (
	person_id INT,
	position_id INT,
	PRIMARY KEY (person_id, position_id),
	FOREIGN KEY (person_id) REFERENCES hr.person (person_id),
	FOREIGN KEY (position_id) REFERENCES hr.position (position_id)
);


BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO hr.person (first_name, last_name, gender)
		VALUES ('Joan', 'Smith', 'F') -- SUCESS

		INSERT INTO hr.person_position (person_id, position_id)
		VALUES (@@IDENTITY, 1) -- FAIL
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;
GO


INSERT INTO hr.person (first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES ('Peter','Drucker','F');








-- SEQUENCE

CREATE SEQUENCE item_counter
	AS INT
	START WITH 10
	INCREMENT BY 10;


SELECT NEXT VALUE FOR item_counter;

SELECT NEXT VALUE FOR item_counter;




CREATE SCHEMA procurement;
GO

CREATE TABLE procurement.purchase_orders (
	order_id INT PRIMARY KEY,
	vendor_id INT NOT NULL,
	order_date DATE NOT NULL
);




CREATE SEQUENCE procurement.order_number
	AS INT
	START WITH 1
	INCREMENT BY 1;



INSERT INTO procurement.purchase_orders
(
	order_id, 
	vendor_id, 
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 1, '2019-04-30');


INSERT INTO procurement.purchase_orders
(
	order_id,
	vendor_id,
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 2, '2019-05-01');


INSERT INTO procurement.purchase_orders
(
	order_id,
	vendor_id,
	order_date
)
VALUES
	(NEXT VALUE FOR procurement.order_number, 3, '2019-05-02');


SELECT
	order_id,
	vendor_id,
	order_date
FROM
	procurement.purchase_orders;






CREATE SEQUENCE procurement.receipt_no
	START WITH 1
	INCREMENT BY 1;


CREATE TABLE procurement.good_receipts
(
	receipt_id INT PRIMARY KEY
		DEFAULT (NEXT VALUE FOR procurement.receipt_no),
	order_id INT NOT NULL,
	full_receipt BIT NOT NULL,
	receipt_date DATE NOT NULL,
	note VARCHAR(100)
);


CREATE TABLE procurement.invoice_receipts
(
	receipt_id INT PRIMARY KEY
		DEFAULT (NEXT VALUE FOR procurement.receipt_no),
	order_id INT NOT NULL,
	is_late BIT NOT NULL,
	receipt_date DATE NOT NULL,
	note NVARCHAR(100)
);


INSERT INTO procurement.good_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    1,
    '2019-05-12',
    'Goods receipt completed at warehouse'
);
INSERT INTO procurement.good_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-12',
    'Goods receipt has not completed at warehouse'
);

INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-13',
    'Invoice duly received'
);
INSERT INTO procurement.invoice_receipts(
    order_id, 
    is_late,
    receipt_date,
    note
)
VALUES(
    2,
    0,
    '2019-05-15',
    'Invoice duly received'
);



SELECT * FROM procurement.good_receipts;
SELECT * FROM procurement.invoice_receipts;


SELECT
	*
FROM
	sys.sequences;







-- ALTER TABLE ADD COLUMNS