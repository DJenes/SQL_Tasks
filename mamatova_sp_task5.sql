CREATE OR REPLACE FUNCTION mamatova.totaldue_task5()
RETURNS TRIGGER 
language plpgsql
AS $$
DECLARE
 duplicates int;
BEGIN


 CASE TG_OP


   WHEN 'INSERT' THEN

      INSERT INTO 
	   mamatova.salesorderheader(salesorderid,customerid,salespersonid,creditcardid)
	   VALUES
	   (new.salesorderid,new.customerid,new.salespersonid,new.creditcardid);
	   UPDATE mamatova.salesorderheader s1
	   SET totaldue = tb1.tl_sum
	   FROM 
	   (   SELECT sum(linetotal)tl_sum,salesorderid
		   FROM mamatova.salesorderdetail 
		   GROUP BY salesorderid
		   
		) tb1
	     WHERE s1.salesorderid = tb1.salesorderid; 
         RETURN new;

   WHEN 'UPDATE' THEN
     SELECT count (*) INTO duplicates 
	 FROM mamatova.salesorderdetail
	 WHERE salesorderid = old.salesorderid;
     IF OLD.linetotal <> NEW.linetotal THEN 
	   IF duplicates >0 THEN 
       UPDATE mamatova.salesorderheader s1
	      SET totaldue = totaldue+ new.linetotal	        
	       WHERE old.salesorderid = new.salesorderid; 
           RETURN new;
		   ELSE 
		   UPDATE mamatova.salesorderheader s1
	       SET totaldue = new.linetotal	        
	       WHERE old.salesorderid = new.salesorderid; 
           RETURN new;
		    
		   END IF;
		   END IF ;
       
   WHEN 'DELETE' THEN 
           SELECT count (*) INTO duplicates 
		   FROM mamatova.salesorderdetail
		   WHERE salesorderid = old.salesorderid;
		   IF duplicates > 0 THEN
		   UPDATE mamatova.salesorderheader s1
	        SET totaldue = totaldue+ old.linetotal	        
	        WHERE salesorderid =old.salesorderid; 
            RETURN new;
		   ELSE 		    
           DELETE FROM mamatova.salesorderheader WHERE salesorderid = OLD.salesorderid;
           RETURN NULL;
		   END IF;

   END CASE;

 


 END;   

$$

CREATE TRIGGER mamatova_trg_task5
AFTER INSERT OR UPDATE OR DELETE
ON mamatova.salesorderdetail
FOR EACH ROW
EXECUTE PROCEDURE mamatova.totaldue_task5();


INSERT INTO mamatova.salesorderdetail
VALUES(83671, 1123, 'test', 3, 12, 1, 6, 0, 1, 'b408c96d-d9e6-403b-8470-2cc176c41283' , 
     '2011-05-31 00:00:00', 112,3457,21456);


UPDATE mamatova.salesorderdetail
SET linetotal = 457
WHERE salesorderid = 83671;



SELECT * 
  FROM mamatova.salesorderheader
 WHERE salesorderid = 83671;


DELETE FROM mamatova.salesorderdetail
WHERE salesorderid = 83671;
