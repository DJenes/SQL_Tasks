CREATE OR REPLACE PROCEDURE mamatova.report_task3(input_data int)
language plpgsql
AS $$ 
   
  BEGIN 
  
  INSERT INTO mamatova.sales_report_total_daily(date_report,onlineorderflag,
												 sum_total,avg_total,qty_orders)
  SELECT  p1.orderdate,p1.onlineorderflag,p1.sum_total,p1.avg_total,p1.total_sales
  FROM
   ( SELECT orderdate,onlineorderflag,
  SUM(subtotal)OVER(PARTITION BY DATE_PART('day', orderdate) 
				ORDER BY DATE_PART('day', orderdate)) as sum_total ,
  AVG(totaldue)	OVER(PARTITION BY DATE_PART('day', orderdate) 
				ORDER BY DATE_PART('day', orderdate)) as avg_total,				
  COUNT(*)	OVER(PARTITION BY DATE_PART('day', orderdate) 
				ORDER BY DATE_PART('day', orderdate)) as total_sales
  FROM sales.salesorderheader
  WHERE DATE_PART('year', orderdate)>= 2011 and DATE_PART('year', orderdate)<2021
   ) AS p1
   GROUP by p1.orderdate,p1.onlineorderflag, p1.sum_total,p1.avg_total,p1.total_sales;
   
   
  INSERT INTO mamatova.sales_report_total_monthly(date_report,onlineorderflag,
												 sum_total,avg_total,qty_orders)
   SELECT  p1.orderdate,p1.onlineorderflag, p1.sum_total,p1.avg_total,p1.total_sales
  FROM
   ( SELECT orderdate,onlineorderflag,
  SUM(subtotal)OVER(PARTITION BY DATE_PART('month', orderdate) 
				ORDER BY DATE_PART('month', orderdate)) as sum_total ,
  AVG(totaldue)	OVER(PARTITION BY DATE_PART('month', orderdate) 
				ORDER BY DATE_PART('month', orderdate)) as avg_total,				
  COUNT(*)	OVER(PARTITION BY DATE_PART('month', orderdate) 
				ORDER BY DATE_PART('month', orderdate)) as total_sales
  FROM sales.salesorderheader
  WHERE DATE_PART('year', orderdate)>= 2011 and DATE_PART('year', orderdate)<2021
   ) AS p1
   GROUP by p1.orderdate,p1.onlineorderflag,p1.sum_total,p1.avg_total,p1.total_sales;
   
   INSERT INTO mamatova.sales_report_total_yearly(date_report,onlineorderflag,
												 sum_total,avg_total,qty_orders)
   SELECT  p1.orderdate,p1.onlineorderflag, p1.sum_total,p1.avg_total,p1.total_sales
  FROM
   ( SELECT orderdate,onlineorderflag,
  SUM(subtotal)OVER(PARTITION BY DATE_PART('year', orderdate) 
				ORDER BY DATE_PART('year', orderdate)) as sum_total ,
  AVG(totaldue)	OVER(PARTITION BY DATE_PART('year', orderdate) 
				ORDER BY DATE_PART('year', orderdate)) as avg_total,				
  COUNT(*)	OVER(PARTITION BY DATE_PART('year', orderdate) 
				ORDER BY DATE_PART('year', orderdate)) as total_sales
  FROM sales.salesorderheader
  WHERE DATE_PART('year', orderdate)>= 2011 and DATE_PART('year', orderdate)<2021
   ) AS p1 
   GROUP by p1.orderdate,p1.onlineorderflag, p1.sum_total,p1.avg_total,p1.total_sales;

 END; 
$$

CALL mamatova.report_task3(4)