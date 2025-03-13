



--------------------====first option====-----------------------------------------------------

--------1
	SELECT ProductName AS Name FROM Products;
--------2
SELECT * FROM Customers AS Client;
--------3
SELECT ProductName FROM Products
UNION
SELECT ProductName
FROM Products_Discontinued;
--------4
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM
Products_Discontinued;
--------5
SELECT * FROM Products 
	UNION ALL
	SELECT Orders;
--------6
SELECT DISTINCT CustomerName, Country 
FROM Customers;
--------7
SELECT ProductName, Price, 
CASE 
WHEN Price > 100 THEN 'High'
ELSE 'Low'
END AS PriceCategory
FROM Products;
--------8
SELECT Country, COUNT(*) AS
EmployeeCount
FROM Employees
WHERE Department = 'Sales'
GROUP BY Country;
-------9
SELECT CategoryID, COUNT(ProductID) AS ProductCount FROM Products GROUP BY CategoryID;
-------10
SELECT ProductName, Stock,
       IIF(Stock > 100, 'Yes', 'No') AS 
	   InStock
	   FROM Products;


-----------------------============second option=============------------------------------
--------11
SELECT O.OrderID, C.CustomerName AS
ClientName, O.OrderDate
FROM Orders AS O
INNER JOIN Customers AS C ON
O.CustomerID = C.CustomerID;
--------12
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;
--------13
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM
Discontinued_Products;

---------14
SELECT CustomerName, 
       CASE 
           WHEN (SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID) > 5 
           THEN 'Eligible' 
           ELSE 'Not Eligible' 
       END AS Status
FROM Customers;

---------15
SELECT ProductName, IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;
---------16
SELECT CustomerID, COUNT(OrderID) AS
TotalOrders
FROM Orders
GROUP BY CustomerID;
---------17
SELECT * 
FROM Employees
WHERE Age < 25 OR Salary > 6000;
---------18
SELECT Region, SUM(SalesAmount) AS TotalSales 
FROM Sales
GROUP BY Region;
---------19
SELECT C.CustomerName, O.OrderID, O.OrderDate AS
PurcheseDate
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID;
---------20
UPDATE Employees
SET Salary = Salary * 1.1
WHERE Department = 'HR';

--------------------------================third option================------------------------------

---------21
SELECT ProductID, SUM(Amount) AS TotalAmount, 'Sale' AS Type
FROM Sales
GROUP BY ProductID
UNION ALL
SELECT ProductID, SUM(Amount) AS TotalAmount, 'Return' AS Type
FROM Returns
GROUP BY ProductID;
---------22
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM DiscontinuedProducts;
---------23
SELECT CustomerID, SUM(SalesAmount) AS TotalSales,
	CASE 
WHEN SUM(SalesAmount) > 10000 THEN 'Top Tier'
WHEN SUM(SalesAmount) BETWEEN 5000 AND 10000 THEN 'Mid Tier'
ELSE 'Low Tier'
END AS SalesCategory
FROM Sales
GROUP BY CustomerID;
---------24
DECLARE @EmployeeID INT = (SELECT MIN(EmployeeID) FROM Employees);
WHILE @EmployeeID IS NOT NULL
BEGIN
    UPDATE Employees
    SET Salary = Salary * 1.05
    WHERE EmployeeID = @EmployeeID;
SET @EmployeeID = (SELECT MIN(EmployeeID) FROM Employees WHERE EmployeeID > @EmployeeID);
END;
---------25
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices;
--------26
SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID, ProductID, Region;
--------27
SELECT ProductID, Quantity,
       CASE 
           WHEN Quantity >= 100 THEN 20
           WHEN Quantity BETWEEN 50 AND 99 THEN 10
           ELSE 0
END AS Discount
FROM Orders;
-------28
SELECT P.ProductID, P.ProductName, 'In Stock' AS Status
FROM Products AS P
UNION
SELECT D.ProductID, D.ProductName, 'Discontinued' AS Status
FROM DiscontinuedProducts AS D;
-------29
SELECT ProductID, ProductName, Stock,
       IIF(Stock > 0, 'Available', 'Out of Stock') AS StockStatus
FROM Products;
-------
SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM VIP_Customers;
