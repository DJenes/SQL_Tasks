CREATE VIEW vPerson AS
SELECT p1.title, p1.firstname, p1.lastname, p2.emailaddress
FROM person.person p1 
INNER JOIN person.emailaddress p2
ON p1.businessentityid = p2.businessentityid 


WITH humanresorse AS 
(
	SELECT BusinessEntityId,NationalIdNumber,JobTitle
	  FROM HumanResources.Employee
				  
)
, personfullname AS
(
	  SELECT FirstName,LastName,BusinessEntityId
		FROM Person.Person
	

)
, phonenumber AS
	(
	   SELECT PhoneNumber,BusinessEntityId
	   FROM Person.PersonPhone
	   )
	   
    SELECT h1.BusinessEntityId,h1.NationalIdNumber,h1.JobTitle,p1.FirstName,p1.LastName,p2.PhoneNumber
      FROM humanresorse h1
INNER JOIN personfullname p1 
 	    ON h1.BusinessEntityId = p1.BusinessEntityId
INNER JOIN phonenumber p2 
 	    ON p1.BusinessEntityId = p2.BusinessEntityId		
		
       