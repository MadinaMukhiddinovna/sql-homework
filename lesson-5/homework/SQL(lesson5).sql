
CREATE TABLE Products (
 ProductID INT PRIMARY KEY,
 ProductName VARCHAR(255),
 Price DECIMAL(10,2),
 Stock INT,
 CategoryID INT,
 Discontinued BIT
);
CREATE TABLE Discontinued_Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10,2) 
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductID INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Country VARCHAR(255)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(255),
    Country VARCHAR(255)
);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
SalesAmount DECIMAL(10,2),
Region VARCHAR(255)
);
INSERT INTO Products (ProductID, ProductName, Price, Stock, CategoryID, Discontinued) VALUES
(101, 'Smartphone', 700.00, 150, 1, 0),
(102, 'Tablet', 300.00, 120, 1, 0),
(103, 'Headphones', 50.00, 200, 2, 0),
(104, 'Smartwatch', 250.00, 80, 2, 1), -- Discontinued
(105, 'Camera', 400.00, 50, 3, 0);

INSERT INTO Discontinued_Products (ProductID, ProductName, Price) VALUES
(104, 'Smartwatch', 250.00),
(106, 'MP3 Player', 80.00);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductID) VALUES
(201, 1, '2025-03-05', 101),
(202, 2, '2025-03-06', 103),
(203, 3, '2025-03-07', 105),
(204, 1, '2025-03-08', 102);

INSERT INTO Customers (CustomerID, CustomerName, Country) VALUES
(1, 'Michael Johnson', 'USA'),
(2, 'Sophie Lee', 'UK'),
(3, 'Carlos Gomez', 'Spain');

INSERT INTO Employees (EmployeeID, EmployeeName, Age, Salary, Department, Country) VALUES
(1, 'David Smith', 29, 5200, 'Marketing', 'USA'),
(2, 'Olivia Brown', 27, 4800, 'HR', 'Canada'),
(3, 'James Wilson', 34, 6300, 'IT', 'Germany');

INSERT INTO Sales (SaleID, ProductID, SalesAmount, Region) VALUES
(301, 101, 14000, 'North America'),
(302, 103, 8600, 'Europe'),
(303, 105, 5000, 'Asia');

----------------------------------------------------------------------------------------------

--------------------====first option====-----------------------------------------------------

SELECT ProductName AS Name FROM Products;

SELECT * FROM Customers AS Client;

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Products_Discontinued';

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%Products%';

CREATE TABLE Products_Discontinued (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products_Discontinued (ProductID, ProductName, Price, Stock)
VALUES 
(201, 'Old Phone', 150, 0),
(202, 'Vintage Radio', 80, 2),
(203, 'Classic Watch', 200, 1);

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discontinued;

SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM
Products_Discontinued;

SELECT * FROM Products
UNION ALL
SELECT * FROM Orders;

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Products';

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Orders';

SELECT ProductID, ProductName, Price, NULL AS OrderDate 
FROM Products
UNION ALL
SELECT ProductID, 'Unknown' AS ProductName, NULL AS Price, OrderDate 
FROM Orders;

SELECT DISTINCT CustomerName, Country
FROM Customers;

SELECT ProductName, Price,
CASE
WHEN Price > 100 THEN 'High'
ELSE 'LOW'
END AS PriceCategory
FROM Products;
-------
SELECT Country, Department, COUNT(*) AS
EmployeeCount
FROM Employees
GROUP BY Country, Department;
-------
SELECT CategoryID, COUNT(ProductID) AS ProductCount FROM Products GROUP BY CategoryID;
-------
SELECT ProductName, Stock,
       IIF(Stock > 100, 'Yes', 'No') AS 
	   InStock
	   FROM Products;


-----------------------============second option=============------------------------------

SELECT O.OrderID, C.CustomerName AS
ClientName
FROM Orders AS O
INNER JOIN Customers AS C ON
O.CustomerID = C.CustomerID;
-----------------------------------------
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'OutOfStock';

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%Stock%';

CREATE TABLE OutOfStock (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Stock INT
);
INSERT INTO OutOfStock (ProductID, ProductName, Stock)
VALUES 
(401, 'Gaming Mouse', 0),
(402, 'Wireless Keyboard', 0),
(403, 'Mechanical Keyboard', 0);

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;
---=====================================
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock;

SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM
Discontinued_Products;


SELECT CustomerName, 
       CASE WHEN OrderCount > 5 THEN 'Eligible' ELSE 'Not Eligible' END AS Status
FROM Customers;
---------------------==================================
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Customers';

SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID;

SELECT C.CustomerID, C.CustomerName, 
       CASE 
           WHEN COUNT(O.OrderID) > 5 THEN 'Eligible'
           ELSE 'Not Eligible'
       END AS OrderStatus
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;
--------------------------------------------------------------------
SELECT CustomerName, 
       CASE WHEN OrderCount > 5 THEN 'Eligible' ELSE 'Not Eligible' END AS Status
FROM Customers;

SELECT ProductName, IIF(Price > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

SELECT CustomerID, COUNT(OrderID) AS
OrderCount
FROM Orders
GROUP BY CustomerID;

SELECT * FROM Employees WHERE Age < 25 OR Salary > 6000;

SELECT Region, SUM(SalesAmount) AS TotalSales 
FROM Sales
GROUP BY Region;

SELECT C.CustomerName, O.OrderDate AS
OrderPlaced
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID;

UPDATE Employees
SET Salary = Salary * 1.1
WHERE Department = 'HR';

--------------------------================third option================------------------------------

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Returns';

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '%Return%';

CREATE TABLE Returns (
    ProductID INT PRIMARY KEY,
    ReturnAmount DECIMAL(10,2)
);

INSERT INTO Returns (ProductID, ReturnAmount)
VALUES 
(101, 500),
(102, 300),
(103, 250);

SELECT ProductID, SUM(SalesAmount) AS Total_Amount, 'Sale' AS Type
FROM Sales
GROUP BY ProductID

UNION ALL

SELECT ProductID, SUM(ReturnAmount) AS Total_Amount, 'Return' AS Type
FROM Returns
GROUP BY ProductID;

SELECT ProductID, ProductName FROM Products
INTERSECT
SELECT ProductID, ProductName FROM Discontinued_Products;

----------------------------------------------------------------------

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Sales';

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Sales';

------------------------------------------------------------------
SELECT ProductID, ProductName, TotalSales,
       CASE 
           WHEN TotalSales > 10000 THEN 'Top Tier'
           WHEN TotalSales BETWEEN 5000 AND 10000 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SalesCategory
FROM Sales;

CREATE TABLE Sales (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    TotalSales DECIMAL(10,2)
);
INSERT INTO Sales (ProductID, ProductName, TotalSales)
VALUES 
(101, 'Laptop', 12000),
(102, 'Phone', 7000),
(103, 'Tablet', 4000);

--------------------------------------------------------
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Employees';

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Employees';

DECLARE @EmployeeID INT = 1;
WHILE @EmployeeID <= (SELECT MAX(EmployeeID) FROM Employees)
BEGIN
    IF (SELECT Department FROM Employees WHERE EmployeeID = @EmployeeID) = 'HR'
    BEGIN
        UPDATE Employees 
        SET Salary = Salary * 1.1 
        WHERE EmployeeID = @EmployeeID;
    END

    SET @EmployeeID = @EmployeeID + 1;
END;

------------------------------------------------------------------------
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Department, Salary)
VALUES 
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 6000),
(3, 'Charlie', 'HR', 5500);

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME = 'Invoices';

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Invoices';


CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    OrderID INT
);

INSERT INTO Invoices (InvoiceID, CustomerID, OrderID)
VALUES 
(1, 101, 5001),
(2, 102, 5002),
(3, 103, 5003);

SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices;

SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices;
-------------------------------------------------------------------------------------
SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'CustomerID';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Sales';

ALTER TABLE Orders ADD CustomerID INT;

ALTER TABLE Sales ADD CustomerID INT;

UPDATE Orders
SET CustomerID = 101
WHERE OrderID = 1;

UPDATE Sales
SET CustomerID = 101
WHERE ProductID = 1;

SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID, ProductID, Region;

SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID, ProductID, Region;

----------------------------------------------------------------------------
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Orders';

ALTER TABLE Orders ADD Quantity INT;

UPDATE Orders 
SET Quantity = 5 
WHERE OrderID = 1;

UPDATE Orders 
SET Quantity = 15 
WHERE OrderID = 2;

UPDATE Orders 
SET Quantity = 25 
WHERE OrderID = 3;

SELECT OrderID, ProductID, Quantity,
       CASE 
           WHEN Quantity >= 20 THEN 'High Discount'
           WHEN Quantity BETWEEN 10 AND 19 THEN 'Medium Discount'
           ELSE 'No Discount'
       END AS Discount
FROM Orders;

SELECT ProductID, Quantity,
       CASE 
           WHEN Quantity > 100 THEN 20
           WHEN Quantity BETWEEN 50 AND 100 THEN 10
           ELSE 5
       END AS Discount
FROM Orders;

-------------------------------------------------------------------------------------------
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Products';

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'DiscontinuedProducts';

ALTER TABLE Products ADD Stock INT;
ALTER TABLE DiscontinuedProducts ADD Stock INT;

UPDATE Products 
SET Stock = 10 
WHERE ProductID = 500;

UPDATE Products 
SET Stock = 0 
WHERE ProductID = 501;

UPDATE DiscontinuedProducts 
SET Stock = 0 
WHERE ProductID = 600;

SELECT ProductID, ProductName, Stock,
'Active' 
AS Status 
FROM Products

UNION 

SELECT ProductID, ProductName, Stock,
'Discontinued' AS Status 
FROM DiscontinuedProducts;


SELECT P.ProductID, P.ProductName, 'Available' AS Status
FROM Products P
INNER JOIN Stock S ON P.ProductID = S.ProductID

UNION

SELECT D.ProductID, D.ProductName, 'Discontinued' AS Status
FROM DiscontinuedProducts D
INNER JOIN Stock S ON D.ProductID = S.ProductID;

---------------------------------------------------------------

SELECT ProductID, ProductName, 
       IIF(Stock > 0, 'Available', 'Out of Stock') AS StockStatus
FROM Products;


---------------------------------------------------------------------------
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'VIP_Customers';

ALTER TABLE VIP_Customers ADD CustomerID INT;

UPDATE VIP_Customers 
SET CustomerID = 101 
WHERE CustomerName = 'Alice';

SELECT CustomerID, CustomerName 
FROM Customers

EXCEPT

SELECT CustomerID, CustomerName 
FROM VIP_Customers;

SELECT CustomerID FROM Customers
EXCEPT
SELECT CustomerID FROM VIP_Customers;

---------------------------------------------------------------------------------------------------------ura