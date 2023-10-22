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