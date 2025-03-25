------------homework_9--------------------------
------------first_tasks-------------------------
 SELECT e.EmployeeID, E.EmployeeName,
 e.Salary, d.DepartmentName
 FROM Employees e
 INNER JOIN Departments d 
 ON e.DepartmentID = d.DepartmentID
 WHERE e.Salary > 5000;

 SELECT c.CustomerName, o.OrderID, o.OrderDate
 FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
 WHERE YEAR(o.OrderDate) = 2023;
 
SELECT e.EmployeeID, E.EmployeeName,
d.DepartmentName
FROM Employees e
LEFT JOIN Departments d 
on e.DepartmentID = d.DepartmentID;

SELECT S.SupplierName, p.ProductName
FROM Products p
RIGHT JOIN Suppliers s 
ON P.SupplierID = s.SupplierID;

SELECT o.OrderID, o.OrderDate,  p.PaymentID, p.Amount FROM Orders o 
FULL Orders o 
FULL OUTER JOIN Payments p 
ON O.OrderID = p.OrderID;

--
SELECT e.EmployeeName, m.EmployeeName AS ManagerName
from Employees e 
left join Employees m
on e.ManagerID = m.EmployeeID;


SELECT p.ProductID, p.ProductName, s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 100;

SELECT s.StudentName, c.CourseName
FROM Students s
JOIN StudentCourses sc
ON s.StudentID = sc.StudentID
JOIN Courses c
ON sc.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';

SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) > 3;

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR';

--------------second_tasks------------------------
SELECT e.EmployeeID, e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE (SELECT COUNT(*) 
       FROM Employees 
       WHERE DepartmentID = d.DepartmentID) > 10; 

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleID IS NULL;

SELECT c.CustomerID, c.CustomerName
FROM Customers c 
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(o.OrderID) >= 1;

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e 
FULL OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IS NOT NULL;

SELECT e.EmployeeName, m.EmployeeName as ManagerName 
FROM Employees e
JOIN Employees m 
ON e.ManagerID = m.EmployeeID
ORDER BY m.EmployeeName;

SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Orders o 
LEFT JOIN Customers c 
ON o.CustomerID = c.CustomerID 
WHERE YEAR(o.OrderDate) = 2022;

--
SELECT e.EmployeeName, e.Salary,
d.DepartmentName
FROM Employees e 
JOIN Departments d
ON e.DepartmentID = d.DepartmentID AND
d.DepartmentName = 'Sales' WHERE e.Salary > 5000;

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT';

SELECT o.OrderID, p.PaymentID, p.PaymentDate
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NOT NULL;

SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN OrderDetails od
ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL; 

-----------------third_tasks---------------------------------------------

SELECT e.EmployeeName, e.Salary, d.DepartmentName 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (
SELECT AVG(Salary)
FROM Employees 
WHERE DepartmentID = e.DepartmentID
);

SELECT o.OrderDate 
FROM Orders o 
LEFT JOIN Payments p 
ON o.OrderID = p.orderID
WHERE p.PaymentID IS NULL AND o.OrderDate < '2020-01-01';

SELECT p.ProductName
FROM Products p 
FULL OUTER JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;

SELECT e.EmployeeName, m.EmployeeName AS ManagerName
FROM Employees e 
JOIN Employees m 
ON E.ManagerID = m.EmployeeID
WHERE e.Salary > 5000;

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e 
RIGHT JOIN Departments d 
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

SELECT p.ProductName, s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 1000;

SELECT s.StudentName
FROM Students s
LEFT JOIN StudentCourses sc
ON s.StudentID = sc.StudentID
LEFT JOIN Courses c
ON sc.CourseID = c.CourseID
WHERE c.CourseName <> 'Math 101' OR c.CourseName IS NULL;

SELECT o.OrderID
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) > 2;
