USE SalesDB;
GO

INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com');

INSERT INTO Products VALUES
(1, 'Laptop', 1500.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.00);

INSERT INTO Orders VALUES
(1, 1, '2025-07-01'),
(2, 2, '2025-07-05');

INSERT INTO OrderItems VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1);
GO