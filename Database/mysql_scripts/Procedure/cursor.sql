DELIMITER //

-- use cursor

CREATE PROCEDURE processorders()
BEGIN
	-- Declare local variables
	DECLARE done BOOLEAN DEFAULT 0;
	DECLARE o INT;

	-- Declare the cursor
	DECLARE ordernumbers CURSOR
	FOR
	SELECT order_num
	FROM orders;
	
	-- Open the cursor
	OPEN ordernumbers;
	
	-- Get order number
	FETCH ordernumbers INTO o;
	
	-- Close the cursor
	CLOSE ordernumbers;

END //