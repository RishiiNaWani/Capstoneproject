CREATE Procedure GetMaxQuantity()
begin
    SELECT MAX(Quantity) FROM orders;
END // 
DELIMITER ;
call GetMaxQuantity();
Prepare Getorder FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ? ';
SET @CustomerID = 3 ;
EXECUTE Getorder Using @CustomerID;


DELIMITER //

CREATE PROCEDURE CancelOrder(IN id INT, OUT message VARCHAR(255))
BEGIN
    DELETE FROM orders WHERE OrderId = id;
    SET message = CONCAT('Order No.', id, ' canceled');
END //

DELIMITER ;

SELECt @message;