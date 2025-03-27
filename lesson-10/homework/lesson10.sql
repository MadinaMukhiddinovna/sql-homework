-------------------------------------------easy-level-----------------------------------------------
SELECT 
    o.OrderID, o.OrderDate, o.TotalAmount, c.CustomerName
FROM Orders o
INNER JOIN  Customers c
ON  o.CustomerID = c.CustomerID 
    AND YEAR(o.OrderDate) > 2022;
-----------------------------------------------------
SELECT 
    e.EmployeeID, d.DepartmentName
FROM Employees e
JOIN 
    Departments d
ON   e.DepartmentID = d.DepartmentID 
 AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing');
------------------------------------------------------
SELECT p.ProductName, o.OrderID, o.TotalAmount 
FROM (SELECT * FROM Products WHERE Price > 100) p 
JOIN Orders o 
ON p.ProductID = o.ProductID;
-------------------------------------------------------------
SELECT *
FROM Temp_Orders t
JOIN  Orders o
ON  t.OrderID = o.OrderID;
---------------------------------------------------------------
SELECT e.EmployeeName, t.Top Sales 
FROM Employees e 
CROSS APPLY
(SELECT TOP 5 SaleAmount AS TopSales FROM Sales 
WHERE Sales.EmployeeID = e.EmployeeID
ORDER BY SaleAmount DESC) t;
	 ----------------------------------------------------
SELECT 
    c.CustomerName, o.OrderDate, o.TotalAmount
FROM  Customers c
JOIN 
    Orders o
ON 
    c.CustomerID = o.CustomerID 
    AND YEAR(o.OrderDate) = 2023 
    AND c.LoyaltyStatus = 'Gold';
-------------------------------------------------------------
SELECT 
    c.CustomerName, o.OrderCount
FROM 
    Customers c
JOIN  (SELECT CustomerID, COUNT(*) AS OrderCount
     FROM Orders
     GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID;
--------------------------------------------------------------------
SELECT 
    p.ProductName, s.SupplierName
FROM  Products p
JOIN Suppliers s
ON p.SupplierID = s.SupplierID 
 AND (s.SupplierName = 'Supplier A' OR s.SupplierName = 'Supplier B');
---------------------------------------------------------
SELECT 
    e.EmployeeName, o.LastOrderDate
FROM Employees e
OUTER APPLY 
    (SELECT TOP 1 OrderDate AS LastOrderDate 
     FROM Orders 
     WHERE Orders.EmployeeID = e.EmployeeID 
     ORDER BY OrderDate DESC) o;
------------------------------------------------------------
SELECT 
 d.DepartmentName, e.EmployeeName
FROM Departments d
CROSS APPLY 
 dbo.GetEmployeesInDepartment(d.DepartmentID) e;
	--------------------------------------------------------------------------------


	------------------------medium-------------------------------
	
SELECT C.CustomerID, C.Name, O.OrderID, O.TotalAmount
FROM Customers c
JOIN Orders o
ON C.CustomerID = o.CustomerID AND o.TotalAmount > 5000;

SELECT P.ProductName, s.SaleDate, s.Discount 
FROM Products P 
JOIN Sales s 
on p.ProductID = s.ProductID AND (YEAR(S.SalesDate) = 2022 or s.Discount > 0.20);

SELECT P.ProductName, t.TotalSales 
FROM Products p 
JOIN ( 
SELECT ProductID, SUM (Amount) as TotalSales 
FROM Sales 
GROUP BY ProductID 
) T
ON P.ProductID = t.ProductID;

SELECT P.ProductName, p.Price,
TP.IsDiscontinued 
FROM Products p 
JOIN Temp_Products tp 
ON P.ProductID = TP.ProductID AND tp.IsDiscontinued = 1;

	
SELECT E.EmployeeID, E.Name, 
       ISNULL(SUM(S.Amount), 0) AS TotalSales,
       COUNT(S.SaleID) AS TotalOrders
FROM Employees E
CROSS APPLY (
    SELECT SaleID, Amount
    FROM Sales
    WHERE Sales.ProductID IN (
        SELECT ProductID
        FROM Products
        WHERE Category = 'Electronics'
    )
) S
GROUP BY E.EmployeeID, E.Name;


SELECT E.Name, e.Department, e.Salary 
FROM Employees e
JOIN Departments d 
ON E.Department = d.DepartmentName
AND E.Department = 'HR'
AND E.Salary > 5000;

SELECT O.OrderID, O.TotalAmount, p.PaymentStatus 
FROM Orders o 
JOIN Payments p 
ON O.OrderID = P.OrderID
AND (P.PaymentStatus = 'Fully Paid' OR P.PaymentStatus = 'Partially Paid');

SELECT C.Name, c.City, o.OrderDate, o.TotalAmount
FROM Customers c
OUTER APPLY (
    SELECT TOP 1 OrderDate, TotalAmount 
	FROM Orders o
	WHERE O.CustomerID = c.CustomerID
	ORDER BY OrderDate DESC
) O;
SELECT P.ProductName, p.Rating, s.SaleDate 
FROM Products p 
Join Sales s 
ON P.ProductID = s.ProductID 
AND YEAR(S.SaleDate) = 2023 
AND P.Rating > 4;

SELECT E.Name, e.JobTitle, e.Department 
FROM Employees e 
JOIN Departments d 
ON E.Department = d.DepartmentName
AND (E.Department = 'Sales' OR 
E.JobTitle LIKE '%Manager%'); ---includes employees either in Sales or with a manager title

--------------------------------------------------------------------
SELECT C.Name, c.City, COUNT(O.OrderID) 
AS OrderCount 
from Customers c 
join Orders o 
ON C.CustomerID = o.CustomerID 
AND C.City = 'New York' 
GROUP BY C.Name, c.City 
HAVING COUNT(O.OrderID) > 10;

SELECT P.ProductName, p.Category, s.Discount 
FROM Products p 
JOIN Sales s 
on p.ProductID = S.ProductID
and (p.Category = 'Electronics' OR s.Discount > 0.15);

SELECT D.DepartmentName, c.ProductCount 
FROM Departments d 
join ( 
      SELECT Category, count(ProductID) AS ProductCount
	  FROM Products 
	  GROUP BY Category 
	  ) c
	  ON D.DEPARTMENTNAME = C.CATEGORY;

SELECT E.Name, E.Salary, E.Department
FROM Employees E
JOIN Temp_Employees TE
ON E.EmployeeID = TE.EmployeeID
AND E.Salary > 4000
AND E.Department = 'IT';

SELECT D.DepartmentName, E.EmployeeCount
FROM Departments D
CROSS APPLY (
    SELECT COUNT(*) AS EmployeeCount
    FROM Employees E
    WHERE E.Department = D.DepartmentName
) E;
--
SELECT C.Name, O.TotalAmount
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
AND C.City = 'California'
AND O.TotalAmount > 1000;

SELECT E.Name, E.JobTitle, E.Department
FROM Employees E
JOIN Departments D
ON E.Department = D.DepartmentName
AND (E.Department IN ('HR', 'Finance') OR E.JobTitle LIKE '%Executive%');

SELECT C.Name, O.OrderCount
FROM Customers C
OUTER APPLY (
    SELECT COUNT(OrderID) AS OrderCount
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
) O;

SELECT P.ProductName, P.Price, S.Quantity
FROM Products P
JOIN Sales S
ON P.ProductID = S.ProductID
AND S.Quantity > 100
AND P.Price > 50;

SELECT E.Name, E.Salary, E.Department
FROM Employees E
JOIN Departments D
ON E.Department = D.DepartmentName
AND (E.Department IN ('Sales', 'Marketing') AND E.Salary > 6000);


