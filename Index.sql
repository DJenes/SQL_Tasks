/*
—оздайте таблицу Customer со следующими колонками
Ќа колонке CustomerID создайте ограничение первичного ключа и индекс типа B-tree
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
—оздайте составной индекс типа B-tree на таблице Customer на колонках FirstName и LastName
*/


CREATE INDEX idex_FNLN ON mamatova.Customer USING btree(FirstName,LastName)





/*
—оздайте такой индекс на таблице Customer, чтобы результат выполнени€ запроса
*/


CREATE INDEX idex_Age ON mamatova.Customer USING btree(Age)





/*
—оздайте покрывающий индекс IX_Customer_ModifiedDate дл€ быстрого выполнени€ запроса
и проверьте, что он используетс€ в плане запроса:
*/

CREATE INDEX IX_Customer_ModifiedDate ON mamatova.customer (ModifiedDate) INCLUDE (FirstName,LastName)






/*
”далите индекс PK_CustomerID из таблицы Customer
*/

DROP INDEX  mamatova.idex_cid






/*
—оздайте индекс типа Hash с названием PK_ Modified_Date в таблице Customer на колонке
ModifiedDate
*/
CREATE INDEX PK_Modified_Date ON mamatova.customer USING hash (ModifiedDate)





/*
ѕереименуйте индекс PK_ Modified_Date на PK_ ModifiedDate
*/

ALTER INDEX mamatova.PK_Modified_Date RENAME TO PK_ModifiedDate






/*
—оздайте частичный индекс на колонке email только дл€ тех записей, у которых active = true. »
напишите запрос к таблице, в котором этот индекс будет использоватьс€.
*/

CREATE INDEX email_pk
ON mamatova.customer (email)
WHERE active = true


SELECT email
FROM mamatova.customer
WHERE active = true and  customerid between 55 and 273





/*
—оздайте функциональный индекс в таблице Customer дл€ быстрого поиска записей по такому
правилу: если firstname = Сfirstname1Т и lastname = Сlastname1Т, то мы ищем Сf, lastname1Т.
ѕроверьте план запроса, что этот индекс используетс€.

*/


CREATE INDEX fullname_idx
ON mamatova.customer using Btree ((left(firstname,1)|| ' ' || lastname))

explain(analyze)
SELECT firstname, lastname
FROM mamatova.customer
WHERE (left(firstname,1) || ' ' || lastname) = 'f lastname6'