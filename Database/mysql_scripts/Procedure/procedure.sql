DELIMITER //
CREATE PROCEDURE productpricing(
OUT p1 DECIMAL(8,2),
OUT p2 DECIMAL(8,2),
OUT p3 DECIMAL(8,2)
)
BEGIN
	SELECT Min(prod_price)
	INTO p1
	FROM products;
	SELECT Max(prod_price)
	INTO p2
	FROM products;
	SELECT Avg(prod_price)
	INTO p3
	FROM products;
END //