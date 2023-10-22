INSERT INTO Orders (OrderID, OrderDate, TotalCost, Quantity, CustomerID, MenuID)
VALUES 
    (1, '2023-10-16', 50.00, 2, 1, 2),
    (2, '2023-10-17', 30.00, 1, 2, 4),
    (3, '2023-10-17', 70.00, 3, 3, 1),
    (4, '2023-10-18', 40.00, 4, 4, 5),
    (5, '2023-10-18', 60.00, 5, 5, 3);

INSERT INTO menu (`MenuID`, `MenuItemID`, `Cuisine`, `MenuName`)
VALUES 
    (1, 101, 'Italian', 'Pasta Menu'),
    (2, 201, 'Mexican', 'Taco Menu'),
    (3, 301, 'Chinese', 'Dim Sum Menu'),
    (4, 401, 'Indian', 'Curry Menu'),
    (5, 501, 'Japanese', 'Sushi Menu');
INSERT INTO delivery (`DeliveryID`, `DeliveryStatus`, `DeliveryDate`, `OrderID`)
VALUES 
    (1, 'Delivered', '2023-10-1', 2),
    (2, 'In Transit', '2023-10-17', 4),
    (3, 'Pending', '2023-10-18', 5),
    (4, 'Delivered', '2023-10-19', 1),
    (5, 'In Transit', '2023-10-20', 3);
CREATE VIEW  OrdersView As
SELECT OrderId, Quantity, TotalCost
From orders
WHERE Quantity > 2;
SELECT * FROM OrdersView;
SELECT c.CustomerID, c.FullName, o.OrderID, o.TotalCost, m.MenuName,i.CourseName,i.StarterName
FROM customers c
INNER JOIN Orders o ON  c.CustomerID= o.CustomerID
INNER JOIN menu m ON  o.MenuID= m.MenuID
INNER JOIN menuitem i ON m.MenuItemID = i.MenuItemID
WHERE TotalCost > 40;
SELECT MenuName FROM menu WHERE Exists (SELECT Quantity FROM orders where Quantity > 2 AND menu.MenuID = orders.MenuID) ;
DELIMITER //
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

DELIMITER //

CREATE PROCEDURE CheckBooking(date DATE, tablenum INT, OUT status VARCHAR(255))
BEGIN
    DECLARE booking_count INT;
    
    SELECT COUNT(*)
    INTO booking_count
    FROM bookings
    WHERE BookingDate = date AND TableNumber = tablenum;
    
    IF booking_count > 0 THEN
        SET status = CONCAT('Table ', tablenum, ' already booked');
    ELSE
        SET status = CONCAT('No booking found for Table ', tablenum);
    END IF;
    
END//

DELIMITER ;  

Select BookingDate From bookings;
Call CheckBooking('2021-11-10', '2', @status);
SELECT @status;
DROP PROCEDURE IF EXISTS AddValidBookings;

DELIMITER //

CREATE PROCEDURE AddValidBookings(Id int, date DATE, tablenum INT, customID INT , OUT status VARCHAR(255))
BEGIN
     DECLARE count INT;
     START TRANSACTION;
     
     SELECT COUNT(*)
     INTO count
     FROM Bookings
     WHERE BookingDate = date AND TableNumber = tablenum;
     
     IF count > 0 THEN
        SET status = CONCAT('Table ', tablenum, ' is already booked - canceled');
        ROLLBACK;
     ELSE
        INSERT INTO Bookings(BookingID,BookingDate, TableNumber, CustomerID)
        VALUES (Id, date, tablenum, customID);
        SET status = CONCAT('Booking successful for Table ', tablenum);
        COMMIT;
     END IF;
END//


DELIMITER ;

Call AddValidBookings('6','2011-04-23', '2','3', @status);

SELECT @status;
DELIMITER //

CREATE PROCEDURE UpdateBooking(booking_id INT, new_date DATE)
BEGIN
    UPDATE bookings
    SET BookingDate = new_date
    WHERE BookingID = booking_id;
END//

DELIMITER ;

CALL UpdateBooking(1, '2021-11-15');



Certainly! To create the AddBooking procedure with the specified input parameters, you can use the following SQL code:

sql
Copy code
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN booking_id INT,
    IN customer_id INT,
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    INSERT INTO bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (booking_id, customer_id, booking_date, table_number);
END//

DELIMITER ;