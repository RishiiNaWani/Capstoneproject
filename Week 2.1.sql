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
SELECT MenuName
FROM menu
WHERE MenuItemID = ANY (
    SELECT MenuID
    FROM orders
    GROUP BY MenuID
    HAVING COUNT(*) > 2
);
