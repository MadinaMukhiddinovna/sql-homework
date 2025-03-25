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
