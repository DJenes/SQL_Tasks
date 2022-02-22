
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
		JOIN (
		SELECT p.firstname,p.lastname,h1.birthdate,p.businessentityid
		FROM person.person p
		JOIN HumanResources.Employee h1
		on p.businessentityid= h1.businessentityid  
		) AS p2
		ON p3.businessentityid = p2.businessentityid
		WHERE emailaddress = email;
		RETURN res ;
		
    END	; 
$$ 
		
SELECT mamatova.get_info_task1('ken0@adventure-works.com')

