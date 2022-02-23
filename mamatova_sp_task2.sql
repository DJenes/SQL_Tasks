/*
Задание 2 (20 балов)
Пример: Есть торговая точка которая сотрудничает с поставщиками и имеет собственные цеха. В некоторых случаях руководство может как отказаться от собственного производства и заказывать у поставщиков так и начать свое производство -  отказаться от поставщиков.
Выполнить: (В вашей собственной схеме нужно создать новую таблицу.)
drop table if exists <your_lastname>.product;
create table <your_lastname>.product as
select *
  from production.product;
Задача: Создать хранимую процедуру для обновления столбца make_flag в таблице <your_lastname>.product, по столбцу name. Замечание: Если для заданного продукта значение флага совпадает вывести на экран  замечание “<YOUR_COMMENT_1>” и если такого продукта нет в таблице вывести “<YOUR_COMMENT_2>”.
Условие:
Создать скрипт:  <your_lastname>_sp_task2.sql
Имя процедуры - <your_lastname>.<procedure_name>_task2
Параметры:
<inp_1> - character varying;
<inp_2> - boolean (true or false).
*/






CREATE OR REPLACE PROCEDURE mamatova.flagchange_taks2(pr_name Varchar,
													  flag_change boolean)
language plpgsql
AS $$
    DECLARE 
	 temp_f boolean;
    BEGIN  
    SELECT makeflag
	INTO temp_f
	FROM mamatova.product
	WHERE product.name = pr_name; 
	IF temp_f = flag_change THEN 
	     RAISE NOTICE 'YOUR_COMMENT_1';
    ELSE 
	    UPDATE mamatova.product
		SET makeflag = flag_change
		WHERE product.name = pr_name; 
	END IF;
	IF NOT EXISTS (SELECT name  FROM mamatova.product WHERE name = pr_name) THEN
         RAISE NOTICE 'YOUR_COMMENT_2';
    END IF;
	COMMIT;		
	END; 	
$$	

CALL mamatova.flagchange_taks2('Lock Nut 14',true)
