SET SHOWPLAN_ALL ON;
GO

 use SalesDB;
 GO;
 
SELECT 
    o.OrderID,
    c.Name,
    SUM(p.Price * oi.Quantity) AS TotalOrderValue
FROM  [dbo].[Orders] o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID, c.Name;
GO

SET SHOWPLAN_ALL OFF;
GO