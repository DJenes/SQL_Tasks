CREATE SCHEMA mamatova
CREATE TABLE testtable(
    id INT NOT NULL,
	name TEXT,
	issold BIT,
	invoicedate DATE
);
INSERT INTO mamatova.TestTable
VALUES
(1, 'Boat', B'1', '2021-11-08'),
(2,'Auto', B'0', '2021-11-09'),
(3,'Plane', null, '2021-12-09');

ALTER TABLE testtable RENAME name TO vehicle
TRUNCATE testtable
DROP TABLE testtable 

