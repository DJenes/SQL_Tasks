/*
Задание 1 (10 балов)
Задача: Зная электронную почту сотрудника нужно получить его и имя и фамилию, а также его возраст.
Условие:
Создать скрипт:  <your_lastname>_sp_task1.sql
Имя процедуры - <your_lastname>.<procedure_name>_task1
Используйте таблицы person.emailaddress, person.person, person.employee
Параметры:
<inp> – character varying(100).
Возврат функции:
<return> – varchar.
Пример вывода: “<firstname> <lastname> - <age>”
*/





CREATE OR REPLACE function  mamatova.get_info_task1(email Varchar(100)) 
RETURNS varchar 
LANGUAGE plpgsql
AS $$
     DECLARE 
	 res varchar;
     BEGIN
		SELECT p2.firstname||' '||p2.lastname||' - '||DATE_PART('year', CURRENT_DATE) - DATE_PART('year', p2.birthdate)
		INTO res
		FROM person.emailaddress p3
		INNER JOIN (
		SELECT p.firstname,p.lastname,h1.birthdate,p.businessentityid
		FROM person.person p
		INNER JOIN HumanResources.Employee h1
		on p.businessentityid= h1.businessentityid  
		) AS p2
		ON p3.businessentityid = p2.businessentityid
		WHERE emailaddress = email;
		RETURN res ;
		
    END	; 
$$ 
		
SELECT mamatova.get_info_task1('ken0@adventure-works.com')

