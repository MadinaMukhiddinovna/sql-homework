------------first level-------------------

  --1-
  SELECT MIN(Price) AS MinPrice
  FROM Products;

  --2-
  SELECT MAX(Salary) AS MaxSalary 
  FROM Employees;

  --3-
  SELECT COUNT(*) AS TotalCustomers
  FROM Customers;

  --4-
  SELECT COUNT(DISTINCT Category) AS UniqueCategories
  FROM Products;

  --5-
  SELECT SUM(SalesAmount) AS TotalSales
  FROM Sales
  WHERE ProductID = 101;

  --6-
  SELECT AVG(Age) AS AverageAge
  FROM Employees;

  --7-
  SELECT Department, COUNT(*) AS
  EmployeesCount
  FROM Employees
  GROUP BY Department;

  --8-
  SELECT Category, MIN(Price) AS MinPrice,
  MAX(Price) AS MaxPrice
  FROM Products
  GROUP BY Category;

  --9-
  SELECT Region, SUM(SalesAmount) AS
  TotalSales
  FROM Sales 
  GROUP BY Region;

  --10-
  SELECT Department, COUNT(*) AS
  EmployeeCount
  FROM Employees
  GROUP BY Department
  HAVING COUNT(*) > 5;

  -------------second level--------------

  --1-
  SELECT Category, SUM(SalesAmount) AS 
  TotalSales, AVG(SalesAmount) AS AvgSales
  FROM Sales
  GROUP BY Category;

  --2-
  SELECT JobTitle, COUNT(*) AS
  EmployeeCount
  FROM Employees
  GROUP BY JobTitle;

  --3-
  SELECT Department, MAX(Salary) AS
  MaxSalary, MIN(Salary) AS MinSalary
  FROM Employees
  GROUP BY Department;

  --4-
  SELECT Department, AVG(Salary) AS
  AvgSalary
  FROM Employees
  GROUP BY Department;
  
  --5-
  SELECT Department, AVG(Salary) AS
  AvgSalary, COUNT(*) AS EmployeeCount
  FROM Employees
  GROUP BY Department;

  --6-
  SELECT ProductID, AVG(Price) AS AvgPrice
  FROM Products
  GROUP BY ProductID
  HAVING AVG(Price) > 100;

  --7-
  SELECT COUNT(DISTINCT ProductID) AS
  ProfuctsAbove100
  FROM Sales
  WHERE Quantity > 100;

--8-
SELECT YEAR(SalesDate) AS Year,
SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SalesDate);

--9-
SELECT Region, COUNT(DISTINCT CustomerID) AS CustomerCount
FROM Orders
GROUP BY Region;

--10-
SELECT Department, SUM(Salary) AS
TotalSalary
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 1000000;

-----------third level-----------
--1-
SELECT Category, AVG(SalesAmount) AS
AvgSales
FROM Sales
GROUP BY Category
HAVING AVG(SalesAmount) > 200;

--2-
SELECT EmployeeID, SUM(SalesAmount) AS
TotalSales
FROM Sales
GROUP BY EmployeeID
HAVING SUM(SalesAmount) > 5000;

--3-
SELECT Department, SUM(Salary) AS
TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 6000;

--4-
SELECT CustomerID, MAX(OrderAmount) AS
MaxOrder, MIN(OrderAmount) AS MinOrder
FROM Orders
GROUP BY CustomerID
HAVING MIN(OrderAmount) >=50;

--5-
SELECT Region, SUM(SalesAmount) AS TotalSales,
COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Sales
GROUP BY Region
HAVING COUNT(DISTINCT ProductID) > 10;

--6-
SELECT ProductCategory,
MIN(OrderQuantity)
AS MinQuantity,
MAX(OrderQuantity)
AS MaxQuantity
FROM Orders
GROUP BY ProductCategory;

--9-
SELECT ProductCategory, ProductID,
COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY ProductCategory, ProductID
HAVING COUNT(OrderID) > 50;
