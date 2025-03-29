-----------------------------------------------------------------------------------------------------
----------homework_11-------------------------------
----------Basic INNER JOIN----------------

SELECT E.Name AS EmployeeName, d.DepartmentName
FROM Employees e 
INNER JOIN Departments d
on e.DepartmentID = d.DepartmentID;

----------LEFT JOIN------------------------
SELECT S.StudentName, c.ClassName
FROM Students s 
LEFT JOIN Classes c 
ON S.ClassID = c.ClassID;

-----------RIGHT JOIN----------------------
SELECT C.CustomerName, o.OrderDate
FROM Orders o 
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID;

------------FULL OUTER JOIN----------------------
SELECT P.ProductName, s.Quantity
FROM Products p
FULL OUTER JOIN Sales s 
on p.ProductID = S.ProductID;

------------SELF JOIN-------------------------
SELECT E.Name AS Employee, m.Name AS Manager
FROM Employees e 
LEFT JOIN Employees m ON E.ManagerID = m.EmployeeID;

------------CROSS JOIN-----------------------
SELECT C.ColorName, s.SizeName 
FROM Colors c 
CROSS JOIN Sizes s;

-------------JOIN WITH WHERE CLAUSE------------
SELECT m.Title, a.Name AS ActorName 
FROM Movies m
INNER JOIN Actors a
ON M.MovieID = a.MovieID
WHERE m.ReleaseYear > 2015;

-------------MULTIPLE JOINS--------------------
SELECT O.OrderDate, c.CustomerName, od.ProductID
FROM Orders o 
JOIN Customers c 
ON O.CustomerID = c.CustomerID
JOIN OrderDetails od
ON o.OrderID = od.OrderID;

------------JOIN WITH AGGREGATION-------------
SELECT P.ProductName, SUM(S.Quantity * p.Price) AS TotalRevenue
FROM Sales s 
JOIN Products p 
ON s.ProductID = p.ProductID 
GROUP BY P.ProductName;
