DELIMITER //

-- Name: ordertotal-- Parameters: onumber = order number
--								  taxable = 0 if not taxable, 1 if taxable
--                                ototal = order total variable

CREATE PROCEDURE ordertotal(
	IN onumber INTEGER,
	IN taxable BOOLEAN,
	OUT ototal DECIMAL(8,2)
)COMMENT 'Obtain order total, optionally adding tax'
BEGIN
	
	-- Declare variable for total
	DECLARE total DECIMAL(8,2);
	-- Declare tax percentage
	DECLARE taxrate INT DEFAULT 6;
	
	-- Get the order total
	SELECT Sum(item_price*quantity)
	FROM orderitems
	WHERE order_num = onumber
	INTO total;
	
	IF taxable THEN
		-- Yes, so add taxrate to the total
		SELECT total+(total/100*taxrate)
		INTO total;
	END IF;
	
	-- And finally, save to out variable
	SELECT total
	INTO ototal;

END //