INSERT INTO mamatova.TestTable
VALUES
(4, 'Bicycle', B'0', '2020-08-23'),
(5,'Rocket', B'1', '2020-01-01'),
(6,'Motorcycle', null, '2020-08-26'),
(7,'Submarine', B'0', '1999-05-16');

INSERT INTO mamatova.TestTable(id,invoicedate)
VALUES
(8,'2020-08-25');
INSERT INTO mamatova.TestTable(id,name)
VALUES
(9,'Scooter');

UPDATE mamatova.testtable 
SET issold = B'0'
WHERE issold IS NULL

DELETE FROM mamatova.testtable 
WHERE name IS NULL
   OR invoicedate IS NULL; 

ALTER TABLE mamatova.testtable ADD UNIQUE (id);

INSERT into mamatova.testtable(id,name)
values (4,'Train')
ON CONFLICT (id)
DO
UPDATE