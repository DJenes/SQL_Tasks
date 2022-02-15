-- 1.1

SELECT p1.firstname, p1.lastname,p2.jobtitle, p2.birthdate
  FROM person.person p1 
  INNER JOIN humanresources.employee p2
     ON p1.businessentityid = p2.businessentityid
	 
	 
	 
--1.2

SELECT p1.firstname, p1.lastname,p2.jobtitle
  FROM 
  (
	 SELECT firstname, lastname,businessentityid
       FROM person.person 
  ) AS p1

 INNER JOIN 
 (
     SELECT jobtitle,businessentityid 
	   FROM humanresources.employee 
 ) AS p2
 ON p1.businessentityid = p2.businessentityid	 
 
 
 --1.3
 
SELECT *
FROM
(
    SELECT p1.firstname, p1.lastname,p2.jobtitle
      FROM 
       (
	     SELECT firstname, lastname,businessentityid
           FROM person.person 
        ) AS p1

    INNER JOIN 
      (
         SELECT jobtitle,businessentityid 
	       FROM humanresources.employee 
       ) AS p2
    ON p1.businessentityid = p2.businessentityid 
)p3
WHERE p3.jobtitle IS NOT NULL 
 
 --1.4
 
SELECT p1.firstname, p1.lastname,p2.jobtitle
          FROM 
             (
	           SELECT firstname, lastname,businessentityid
                 FROM person.person 
             ) AS p1

  CROSS JOIN 
     (
       SELECT jobtitle,businessentityid 
	     FROM humanresources.employee 
      ) AS p2 
 
 
 --1.5
 
SELECT COUNT(*)
   FROM(
         SELECT p1.firstname, p1.lastname,p2.jobtitle
          FROM 
             (
	           SELECT firstname, lastname,businessentityid
                 FROM person.person 
             ) AS p1

  CROSS JOIN 
     (
       SELECT jobtitle,businessentityid 
	     FROM humanresources.employee 
      ) AS p2
 ) p3;
