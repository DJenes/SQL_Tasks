/*
Задание 4 (20 балов)
Пример: В конце отчетного года руководство решило наградить трех лучших сотрудников.
Задача: Создать пользовательскую функцию для определения лучших сотрудников продавшего товаров на большую сумму за отчетный период.
Учитываются только оффлайн заказы.
Условие:
Создать скрипт:  <your_lastname>_sp_task4.sql
Имя процедуры - <your_lastname>.<procedure_name>_task4
Используйте таблицы sales.salesorderheader, person.person
Параметры:
<inp_1> – date;
<inp_2> – date;
Возврат функции:
employeeid(salespesonid, businessentityid) – int;
firstname – nvarchar(50);
lastname – nvarchar(50);
rank – int
*/
CREATE OR REPLACE function  mamatova.top3_employes_task4(start_period date,end_period date) 
RETURNS TABLE (employeeid int,
        fistname varchar(50),
		lastname varchar(50),
		rank int 	   
			   )
LANGUAGE plpgsql
AS $$
      
    BEGIN 
	
	RETURN QUERY 	
              SELECT p2.salespersonid::int ,p2.firstname::varchar(50),p2.lastname::varchar(50),p2.rank::int
              FROM (
                  SELECT p1.salespersonid,p1.firstname,p1.lastname,p1.sales,
                         DENSE_RANK() OVER ( ORDER BY p1.sales DESC) as rank
                  FROM (
                     SELECT DISTINCT s1.salespersonid,p.firstname,p.lastname,
                     SUM(s1.subtotal)OVER(PARTITION BY s1.salespersonid) AS Sales 
                     FROM sales.salesorderheader s1
                     INNER JOIN  person.person p 
                     ON s1.salespersonid = p.businessentityid
	                 WHERE s1.onlineorderflag= false AND s1.orderdate >=start_period and s1.orderdate <end_period
                     ) as p1
                  ) as p2
                WHERE p2.rank < 4;
   
    END; 
     
   $$
    
   SELECT mamatova.top3_employes_task4('2011-01-01','2013-01-01')
   

