USE SalesDB;
GO

--Total Spending per Customer
WITH CustomerSales AS (
    SELECT 
        c.Name AS CustomerName,
        SUM(p.Price * oi.Quantity) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY c.Name
)
SELECT * FROM CustomerSales;

-- Customer Spending Ranking with RANK()
WITH CustomerSales AS (
    SELECT 
        c.CustomerID,
        c.Name,
        SUM(p.Price * oi.Quantity) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.Name
)
SELECT 
    Name,
    TotalSpent,
    RANK() OVER (ORDER BY TotalSpent DESC) AS SpendingRank
FROM CustomerSales;

--Pivot-style Quantity Summary Per Order
SELECT 
    o.OrderID,
    SUM(CASE WHEN p.Name = 'Laptop' THEN oi.Quantity ELSE 0 END) AS LaptopQty,
    SUM(CASE WHEN p.Name = 'Mouse' THEN oi.Quantity ELSE 0 END) AS MouseQty,
    SUM(CASE WHEN p.Name = 'Keyboard' THEN oi.Quantity ELSE 0 END) AS KeyboardQty
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID;


--CTE with Categorization Using CASE
WITH ProductSales AS (
    SELECT 
        p.ProductID,
        p.Name AS ProductName,
        SUM(oi.Quantity) AS TotalSold,
        SUM(oi.Quantity * p.Price) AS GrossRevenue
    FROM Products p
    JOIN OrderItems oi ON p.ProductID = oi.ProductID
    GROUP BY p.ProductID, p.Name
)


--GROUPING SETS for Multi-level Aggregation
SELECT 
    ProductName,
    TotalSold,
    GrossRevenue,
    CASE 
        WHEN TotalSold > 10 THEN 'High Seller'
        WHEN TotalSold BETWEEN 5 AND 10 THEN 'Moderate Seller'
        ELSE 'Low Seller'
    END AS SalesCategory
FROM ProductSales;



SELECT 
    c.Name AS CustomerName,
    p.Name AS ProductName,
    SUM(oi.Quantity) AS TotalQty
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY GROUPING SETS (
    (c.Name, p.Name),
    (c.Name),
    (p.Name),
    ()
);


--LAG() and DATEDIFF to Analyze Customer Purchase Behavior
SELECT 
    c.Name,
    o.OrderDate,
    LAG(o.OrderDate) OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate) AS PreviousOrder,
    DATEDIFF(DAY, LAG(o.OrderDate) OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate), o.OrderDate) AS DaysSinceLast
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;


--Recursive CTE (for Hierarchical Data or Sequence)
WITH OrderHierarchy AS (
    SELECT OrderID, 1 AS Level
    FROM Orders
    WHERE OrderID = 1   

    UNION ALL

    SELECT o.OrderID, oh.Level + 1
    FROM Orders o
    JOIN OrderHierarchy oh ON o.OrderID = oh.OrderID + 1
    WHERE o.OrderID <= 5
)
SELECT * FROM OrderHierarchy;



--Measure Performance with STATISTICS IO and TIME
SET STATISTICS IO ON;
SET STATISTICS TIME ON;


SELECT 
    c.Name,
    COUNT(o.OrderID) AS OrderCount,
    SUM(p.Price * oi.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.Name;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;