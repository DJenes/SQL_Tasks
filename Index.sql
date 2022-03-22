/*
�������� ������� Customer �� ���������� ���������
�� ������� CustomerID �������� ����������� ���������� ����� � ������ ���� B-tree
*/


CREATE TABLE mamatova.Customer (
  CustomerID int,
  FirstName varchar(50),
  LastName varchar(50),
  Email varchar(100),
  ModifiedDate date,
  Age int,
  active boolean,
  CONSTRAINT CustomerID_pk PRIMARY KEY (CustomerID)
)
CREATE INDEX idex_CID ON mamatova.Customer USING btree(CustomerID);




/*
�������� ��������� ������ ���� B-tree �� ������� Customer �� �������� FirstName � LastName
*/


CREATE INDEX idex_FNLN ON mamatova.Customer USING btree(FirstName,LastName)





/*
�������� ����� ������ �� ������� Customer, ����� ��������� ���������� �������
*/


CREATE INDEX idex_Age ON mamatova.Customer USING btree(Age)





/*
�������� ����������� ������ IX_Customer_ModifiedDate ��� �������� ���������� �������
� ���������, ��� �� ������������ � ����� �������:
*/

CREATE INDEX IX_Customer_ModifiedDate ON mamatova.customer (ModifiedDate) INCLUDE (FirstName,LastName)






/*
������� ������ PK_CustomerID �� ������� Customer
*/

DROP INDEX  mamatova.idex_cid






/*
�������� ������ ���� Hash � ��������� PK_ Modified_Date � ������� Customer �� �������
ModifiedDate
*/
CREATE INDEX PK_Modified_Date ON mamatova.customer USING hash (ModifiedDate)





/*
������������ ������ PK_ Modified_Date �� PK_ ModifiedDate
*/

ALTER INDEX mamatova.PK_Modified_Date RENAME TO PK_ModifiedDate






/*
�������� ��������� ������ �� ������� email ������ ��� ��� �������, � ������� active = true. �
�������� ������ � �������, � ������� ���� ������ ����� ��������������.
*/

CREATE INDEX email_pk
ON mamatova.customer (email)
WHERE active = true


SELECT email
FROM mamatova.customer
WHERE active = true and  customerid between 55 and 273





/*
�������� �������������� ������ � ������� Customer ��� �������� ������ ������� �� ������
�������: ���� firstname = �firstname1� � lastname = �lastname1�, �� �� ���� �f, lastname1�.
��������� ���� �������, ��� ���� ������ ������������.

*/


CREATE INDEX fullname_idx
ON mamatova.customer using Btree ((left(firstname,1)|| ' ' || lastname))

explain(analyze)
SELECT firstname, lastname
FROM mamatova.customer
WHERE (left(firstname,1) || ' ' || lastname) = 'f lastname6'