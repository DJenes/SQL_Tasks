--1.1

  SELECT *, COUNT (*)
    FROM HumanResources.Department
GROUP BY departmentid 

-- 1.2

SELECT h1.businessentityid, h1.jobtitle,payrate.max_rate
FROM HumanResources.Employee h1
INNER JOIN 
    (
		SELECT DISTINCT h2.businessentityid,MAX(rate)AS max_rate
                FROM HumanResources.EmployeePayHistory h2
            GROUP BY businessentityid
            ORDER BY businessentityid
	) AS payrate
   ON h1.businessentityid = payrate.businessentityid 	

--1.3

SELECT sub_category.name, MIN(unit_price.unitprice)
FROM
(
SELECT p1.name,p2.productid
FROM Production.ProductSubcategory p1
INNER JOIN (
	   SELECT productid,productsubcategoryid
	   FROM Production.Product
        ) as p2
	ON p2.productsubcategoryid = p1.productsubcategoryid
) AS sub_category

INNER JOIN
(
SELECT  s1.productid, s1.unitprice
  FROM Sales.SalesOrderDetail s1
) AS unit_price
ON sub_category.productid = unit_price.productid
GROUP BY sub_category.name





--1.4

SELECT c.name AS "Category", sub_category.name AS "Subcategory", COUNT(c.name)OVER (PARTITION BY c.name) 
FROM Production.ProductCategory c
LEFT JOIN 
   (
  	  SELECT DISTINCT name,productcategoryid
	    FROM Production.ProductSubcategory
   ) AS sub_category
   ON c.productcategoryid = sub_category.productcategoryid
   GROUP BY c.name,sub_category.name
   ORDER BY c.name 


--1.5 
  


SELECT sub_category.name, AVG(sub_total.subtotal)
FROM
(
SELECT p1.name,p2.productid
FROM Production.ProductSubcategory p1
INNER JOIN (
	   SELECT productid,productsubcategoryid
	   FROM Production.Product
        ) as p2
	ON p2.productsubcategoryid = p1.productsubcategoryid
) AS sub_category

INNER JOIN
(
SELECT s1.subtotal, s2.productid
  FROM Sales.SalesOrderHeader s1
INNER JOIN (
	       SELECT productid, salesorderid
	         FROM Sales.SalesOrderDetail
           ) AS s2
  ON s1.salesorderid = s2.salesorderid
	) AS sub_total
ON sub_category.productid = sub_total.productid
GROUP BY sub_category.name
    
  


--1.6

SELECT businessentityid, rate, ratechangedate
  FROM HumanResources.EmployeePayHistory
 WHERE rate = (
      	      SELECT MAX(rate)
		      FROM HumanResources.EmployeePayHistory 	
             )

 
