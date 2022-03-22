/*
Создайте таблицу Customer со следующими колонками
На колонке CustomerID создайте ограничение первичного ключа и индекс типа B-tree
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
Создайте составной индекс типа B-tree на таблице Customer на колонках FirstName и LastName
*/


CREATE INDEX idex_FNLN ON mamatova.Customer USING btree(FirstName,LastName)





/*
Создайте такой индекс на таблице Customer, чтобы результат выполнения запроса
*/



CREATE INDEX idex_Age ON mamatova.Customer USING btree(Age)





/*
Создайте покрывающий индекс IX_Customer_ModifiedDate для быстрого выполнения запроса
и проверьте, что он используется в плане запроса:
*/


CREATE INDEX IX_Customer_ModifiedDate ON mamatova.customer (ModifiedDate) INCLUDE (FirstName,LastName)






/*
Удалите индекс PK_CustomerID из таблицы Customer
*/


DROP INDEX  mamatova.idex_cid







/*
Создайте индекс типа Hash с названием PK_ Modified_Date в таблице Customer на колонке
ModifiedDate
*/

CREATE INDEX PK_Modified_Date ON mamatova.customer USING hash (ModifiedDate)





/*
Переименуйте индекс PK_ Modified_Date на PK_ ModifiedDate
*/


ALTER INDEX mamatova.PK_Modified_Date RENAME TO PK_ModifiedDate






/*
Создайте частичный индекс на колонке email только для тех записей, у которых active = true. И
напишите запрос к таблице, в котором этот индекс будет использоваться.
*/


CREATE INDEX email_pk
ON mamatova.customer (email)
WHERE active = true


SELECT email
FROM mamatova.customer
WHERE active = true and  customerid between 55 and 273





/*
Создайте функциональный индекс в таблице Customer для быстрого поиска записей по такому
правилу: если firstname = ‘firstname1’ и lastname = ‘lastname1’, то мы ищем ‘f, lastname1’.
Проверьте план запроса, что этот индекс используется.

*/



CREATE INDEX fullname_idx
ON mamatova.customer using Btree ((left(firstname,1)|| ' ' || lastname))

explain(analyze)
SELECT firstname, lastname
FROM mamatova.customer
WHERE (left(firstname,1) || ' ' || lastname) = 'f lastname6'
