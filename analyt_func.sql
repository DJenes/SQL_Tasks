
--1
WITH needed_month AS 
 (     SELECT p1.name,tb1.month_total 
       FROM (
 		     SELECT s1.month_total, s2.productid		 
	     FROM 
	     (   SELECT SUM(subtotal) AS month_total, salesorderid, OrderDate
			 FROM Sales.SalesOrderHeader 
	         WHERE OrderDate >= '2013-01-01' AND OrderDate < '2013-02-01'
		     GROUP BY salesorderid
		 ) as s1
		     INNER JOIN(
			      SELECT productid,salesorderid
				  FROM  Sales.SalesOrderDetail
			 ) as s2
		     ON s1.salesorderid = s2.salesorderid
		   
		   
		 ) as tb1
		  INNER JOIN (
			SELECT name,productid
			FROM Production.Product 
			) AS p1
	    ON tb1.productid  = p1.productid
	    GROUP BY p1.name,tb1.month_total
	    ORDER BY tb1.month_total ASC
	    
)
 
 SELECT  sb1.name,sb1.month_total
 FROM 
 (  
	 SELECT name, month_total,
	 cume_dist() OVER (ORDER BY month_total) AS prc 
	 FROM needed_month
	 GROUP BY name,month_total
	 
  ) AS sb1
  WHERE prc > 0.1 AND prc < 0.9
 
 
 --2
 
 SELECT  DISTINCT name, MIN(listprice) OVER(PARTITION BY productsubcategoryid) AS min_price
FROM Production.Product
ORDER BY min_price DESC 
 
  
 --3
 SELECT m.listprice
FROM (
       SELECT listprice,productsubcategoryid,
       DENSE_RANK() OVER (ORDER BY listprice DESC) as rank  
       FROM Production.Product
	   GROUP BY productsubcategoryid,listprice
      ) as m
WHERE m.rank = 2 and m.productsubcategoryid = 1	 

--4 



WITH needed_month AS 
 (    
 		   SELECT s2.productid,s2.linetotal, extract(year from OrderDate) as year		 
	     FROM 
	     (   SELECT salesorderid, OrderDate
			 FROM Sales.SalesOrderHeader 
		     GROUP BY salesorderid
		 ) as s1
		     INNER JOIN(
			      SELECT productid,salesorderid,linetotal
				  FROM  Sales.SalesOrderDetail
			 ) as s2
		     ON s1.salesorderid = s2.salesorderid
	        GROUP BY s2.productid,s2.linetotal,year
	        ORDER BY year

 ),
  product_category AS 
(      
	  SELECT tb2.name, tb1.productid  
	  FROM Production.ProductCategory tb2
	  INNER JOIN (	
	      SELECT p1.productid,s1.productcategoryid
	        FROM production.product p1
          INNER JOIN (   			  
			 SELECT productcategoryid,productsubcategoryid
			   FROM Production.ProductSubcategory
		   ) AS s1
	   ON p1.productsubcategoryid=s1.productsubcategoryid
	  ) AS tb1
     ON tb2.productcategoryid = tb1.productcategoryid	
) 
    
	SELECT sq2.name,sq2.sales,
	 sq2.denominator/sq2.sales as YoY	
	FROM (
	  SELECT sq1.name,sq1.sales,sq1.year, 
	   sales-LAG(sales) OVER (PARTITION BY sq1.name ORDER BY sq1.year) as denominator   
 
     FROM(	
		 SELECT tb3.name,needed_month.year,   
		 SUM (needed_month.linetotal) OVER (PARTITION BY tb3.name,needed_month.year) AS  sales
		   FROM needed_month
	 INNER JOIN 
		     (
		       SELECT productid,name
			     FROM  product_category
		     ) AS tb3
		   ON needed_month.productid =tb3.productid
		   ORDER BY tb3.name,needed_month.year
		    ) as sq1
     
	 GROUP BY sq1.name,sq1.sales,sq1.year
	 ) AS sq2
	 WHERE sq2.year = 2013
	 ORDER BY sq2.name 
 

	


--5
WITH needed_month AS 
 (
 		SELECT  orderdate,salesorderid,subtotal
	    FROM Sales.SalesOrderHeader
	    WHERE OrderDate >= '2013-01-01' AND OrderDate < '2013-02-01'
	    GROUP BY salesorderid
 
 )
 
 SELECT DISTINCT needed_month.orderdate, MAX(subtotal)
   OVER (PARTITION BY EXTRACT(DAY FROM needed_month.orderdate)
	   ORDER BY needed_month.orderdate
		 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as max_order
  FROM needed_month	
  ORDER BY needed_month.orderdate
  
--6
  
 WITH needed_month AS 
 (    
 		   SELECT s2.productid,s1.Orderdate		 
	     FROM 
	     (   SELECT salesorderid, OrderDate
			 FROM Sales.SalesOrderHeader 
	         WHERE OrderDate >= '2013-01-01' AND OrderDate < '2013-02-01'
		     GROUP BY salesorderid
		 ) as s1
		     INNER JOIN(
			      SELECT productid,salesorderid
				  FROM  Sales.SalesOrderDetail
			 ) as s2
		     ON s1.salesorderid = s2.salesorderid
 
 ), 
 product_subcategory AS 
 (
     SELECT p1.name AS sub_name,p2.name as cat_name,p2.productid
      FROM Production.ProductSubcategory p1
        INNER JOIN (
	              SELECT productid,productsubcategoryid, name
	              FROM Production.Product
         ) as p2
 	  ON p2.productsubcategoryid = p1.productsubcategoryid
) 

   
   SELECT DISTINCT product_subcategory.sub_name,
     mode() WITHIN GROUP (ORDER BY product_subcategory.cat_name) AS mostfreq
    FROM product_subcategory
	INNER JOIN (
		              SELECT productid,Orderdate	
	                  FROM needed_month
       
		) AS s3
	ON s3.productid = product_subcategory.productid
	GROUP BY product_subcategory.sub_name

 
 
 
 
 
    
   
   
   


	
