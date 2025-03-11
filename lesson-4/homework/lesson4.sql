-- first tasks

SELECT TOP(5) *
FROM Employees
ORDER BY Salary DESC;
SELECT DISTINCT ProductName
FROM Products;
SELECT *
from Products
WHERE Price > 100;

SELECT CustomerName
FROM Customers
WHERE CustomerName LIKE 'A%';
SELECT * 
FROM Products 
ORDER BY Price ASC;
SELECT *
FROM Employees
WHERE Salary >= 5000 
  AND Department = 'HR';

SELECT EmployeeID, 
       EmployeeName, 
       ISNULL(Email, 'noemail@example.com') AS Email 
FROM Employees;

SELECT * 
FROM Products 
WHERE Price BETWEEN 50 AND 100;

SELECT DISTINCT Category, ProductName 
FROM Products;

SELECT * 
FROM Products 
ORDER BY ProductName DESC;


--second level

-- Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    Department NVARCHAR(50),
    Salary DECIMAL(10,2),
    Email NVARCHAR(100)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    City NVARCHAR(50),
    PostalCode NVARCHAR(10),
    Email NVARCHAR(100)
);

-- Order table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
); 

-- insert employees
INSERT INTO Employees (FirstName, LastName, Age, Department, Salary, Email) VALUES
('Alice', 'Brown', 28, 'HR', 5500, 'alice@example.com'),
('Bob', 'Smith', 35, 'IT', 7000, 'bob@example.com'),
('Charlie', 'Davis', 40, 'Marketing', 6000, NULL),
('Diana', 'Miller', 29, 'Sales', 4800, 'diana@example.com'),
('Eve', 'Wilson', 45, 'Finance', 7500, NULL);

-- insert products
INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 1200, 30),
('Phone', 'Electronics', 800, 50),
('Desk Chair', 'Furniture', 150, 20),
('Monitor', 'Electronics', 250, 15),
('Headphones', 'Accessories', 100, 40);

-- insert customers
INSERT INTO Customers (CustomerName, City, PostalCode, Email) VALUES
('Anna White', 'New York', '10001', 'anna@gmail.com'),
('Brian Green', 'Los Angeles', '90001', 'brian@yahoo.com'),
('Chris Black', 'Chicago', '60601', NULL),
('Daisy Blue', 'Houston', '77001', 'daisy@gmail.com'),
('Ethan Red', 'Phoenix', '85001', NULL);

-- insert orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-02-10', 150),
(2, '2025-02-20', 300),
(3, '2025-03-05', 100),
(4, '2025-03-08', 250),
(5, '2025-03-09', 400);

---------------------------------
SELECT TOP(10) *
FROM Products
ORDER BY Price DESC;

SELECT EmployeeID,
   COALESCE(FirstName, LastName) AS
   Name
   FROM Employees;
SELECT DISTINCT Category, Price
FROM Products;

select *
from Employees
WHERE Age BETWEEN 30 AND 40
OR Department = 'Marketing';

select *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM Products
WHERE Price <= 1000 AND Stock > 50
order by Stock ASC;

SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

SELECT *
FROM Employees
WHERE Department IN ('HR','IT', 'Finance');

SELECT *
FROM Employees
where Salary > ANY (SELECT AVG(Salary)
FROM Employees);

SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;


--third option

SELECT TOP(10) *
FROM Products
ORDER BY SalesAmount DESC;
-----
SELECT TOP(10) p.ProductID,
p.ProductName, SUM(o.TotalAmount) AS
SalesAmount
FROM Products p
JOIN Orders o ON p.ProductID =
o.OrderID
GROUP BY p.ProductID, p.ProductName
ORDER BY SalesAmount DESC;

SELECT * FROM Products;

ALTER TABLE Products ADD SalesAmount DECIMAL(10,2);

SELECT EmployeeID, 
       COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName 
FROM Employees;

SELECT DISTINCT Category, ProductName, Price 
FROM Products 
WHERE Price > 50;

SELECT * 
FROM Products 
WHERE Price BETWEEN (SELECT AVG(Price) * 0.9 FROM Products) 
               AND (SELECT AVG(Price) * 1.1 FROM Products);

  SELECT *
  FROM Employees
  WHERE Age < 30
  and Department IN ('HR', 'IT')

  SELECT *
  FROM
  Customers 
  where Email like '%@gmail.com';

  SELECT *
  FROM Employees
  WHERE Salary > ALL (SELECT Salary FROM
  Employees WHERE Department = 'Sales');

  DECLARE @Offset INT = 0;
SELECT * 
FROM Employees 
ORDER BY Salary DESC 
OFFSET @Offset
ROWS FETCH NEXT 10 ROWS ONLY;
SELECT * 
FROM Orders 
WHERE OrderDate BETWEEN DATEADD(DAY, -30, GETDATE()) AND GETDATE();
SELECT * 
FROM Employees e
WHERE Salary > ANY (SELECT AVG(Salary) 
FROM Employees
WHERE Department = e.Department);
