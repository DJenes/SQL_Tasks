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