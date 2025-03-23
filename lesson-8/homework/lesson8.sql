HOMEWORK/8
             --1
SELECT 
    C.CustomerName, 
    O.OrderDate
FROM 
    Customers C
INNER JOIN 
    Orders O
ON 
    C.CustomerID = O.CustomerID;

              --2
SELECT 
    E.EmployeeName, 
    ED.Address, 
    ED.Phone
FROM 
    Employees E
INNER JOIN 
    EmployeeDetails ED
ON 
    E.EmployeeID = ED.EmployeeID;
	          --3
	SELECT 
	P.ProductName,
	C.CategoryName
	FROM Products P
	INNER JOIN Categories C ON P.CategoryID = C.CategoryID;
              --4
SELECT 
      C.CustomerName,
	  O.OrderDate
	FROM
	Customers C
	LEFT JOIN Orders O 
ON C.CustomerID = O.CustomerID;
              --5
	SELECT O.OrderID,
	P.ProductName,
	OD.Quantity
	FROM Orders O
	JOIN OrderDetails OD ON O.OrderID = OD.OrderID
	JOIN Products P
	ON OD.ProductID = P.ProductID;
	          --6
SELECT 
P.ProductName,
C.CategoryName
FROM Products P
CROSS JOIN 
Categories C;
              --7
SELECT 
    C.CustomerName, 
    O.OrderID, 
    O.OrderAmount
FROM 
    Customers C
INNER JOIN 
    Orders O
ON 
    C.CustomerID = O.CustomerID;
	          --8
	SELECT 
	    P.ProductName,
		O.OrderID,
		O.OrderAmount
   FROM 
      Products P
	  CROSS JOIN
	  Orders O
   WHERE 
      O.OrderAmount > 500;
	          --9
SELECT 
     E.EmployeeName,
	 D.DepartmentName
FROM 
     Employees E
INNER JOIN 
     Departments D
ON E.DepartmentID = D.DepartmentID;
             --10
SELECT 
    C.CustomerName, 
    O.OrderDate
FROM 
    Customers C
JOIN 
    Orders O
ON 
    C.CustomerID <> O.CustomerID;
	           --11
SELECT 
      C.CustomerName,
	  COUNT(O.OrderID) AS TotalOrders
FROM 
      Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY 
C.CustomerName;
                --12
SELECT 
     S.StudentName,
	 C.CourseName
FROM 
Students S
JOIN StudentCourses SC
ON S.StudentID = SC.StudentID
JOIN Courses C
ON SC.CourseID = C.CourseID;
               --13
SELECT 
     E.EmployeeName,
	 D.DepartmentName,
	 E.Salary
FROM
     Employees E
CROSS JOIN 
     Departments D
WHERE 
     E.Salary > 5000;

   	            --14
SELECT 
    E.EmployeeName, 
    ED.Address, 
    ED.Phone
FROM 
    Employees E
JOIN 
    EmployeeDetails ED
ON 
    E.EmployeeID = ED.EmployeeID;
	            --15
SELECT 
  P.ProductName,
    S.SupplierName
FROM 
    Products P
JOIN 
  Suppliers S
ON P.SupplierID = S.SupplierID
WHERE S.SupplierName = 'Supplier A'
;
                 --16
SELECT 
      P.ProductName,
	  S.SalesQuantity
FROM Products P
LEFT JOIN Sales S
ON P.ProductID = S.ProductID;

                 --17
SELECT 
    E.EmployeeName, 
    E.Salary, 
    D.DepartmentName
FROM 
    Employees E
JOIN 
    Departments D
ON 
    E.DepartmentID = D.DepartmentID
WHERE 
    E.Salary > 4000 
    AND D.DepartmentName = 'HR';
	             --18
SELECT 
    P.ProductName, 
    S.SalesAmount
FROM 
    Products P
JOIN 
    Sales S
ON 
    P.Price >= S.SalesAmount;
                 --19
SELECT 
    P.ProductName, 
    S.SupplierName
FROM 
    Products P
JOIN 
    Suppliers S
ON 
    P.SupplierID = S.SupplierID
WHERE 
    P.Price >= 50;
	              --20
SELECT 
    S.SaleID, 
    R.RegionName, 
    S.SalesAmount
FROM 
    Sales S
CROSS JOIN 
    Regions R
WHERE 
    S.SalesAmount > 1000;
	              --21
SELECT 
    A.AuthorName, 
    B.BookTitle
FROM 
    Authors A
JOIN 
    AuthorBooks AB
ON 
    A.AuthorID = AB.AuthorID
JOIN 
    Books B
ON 
    AB.BookID = B.BookID;
                  --22
SELECT 
    P.ProductName, 
    C.CategoryName
FROM 
    Products P
JOIN Categories C
ON  P.CategoryID = C.CategoryID
WHERE  C.CategoryName <> 'Electronics';
	               --23
SELECT 
    O.OrderID, 
    P.ProductName, 
    O.Quantity
FROM 
    Orders O                
CROSS JOIN 
    Products P
WHERE 
    O.Quantity > 100;

                    --24

 SELECT 
    E.EmployeeName, 
    E.YearsOfExperience
FROM 
    Employees E
JOIN 
    Departments D
ON 
    E.DepartmentID = D.DepartmentID
WHERE 
    E.YearsOfExperience > 5;
	                --25
-- INNER JOIN
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

-- LEFT JOIN
SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D
ON E.DepartmentID = D.DepartmentID;
                      --26
SELECT
    p.ProductName,
    s.SupplierName,
    c.CategoryName
FROM 
    Products p
    CROSS JOIN Suppliers s
    JOIN Categories c
    ON p.CategoryID = c.CategoryID
WHERE 
    c.CategoryName = 'Category A';
	                   --27
SELECT 
    C.CustomerName, 
    COUNT(O.OrderID) AS TotalOrders
FROM 
    Customers C
JOIN 
    Orders O
ON 
    C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerName
HAVING 
    COUNT(O.OrderID) >= 10;

                       --28
	SELECT 
    C.CourseName, 
    COUNT(SC.StudentID) AS StudentCount
FROM 
    Courses C
JOIN 
    StudentCourses SC
ON 
    C.CourseID = SC.CourseID
GROUP BY 
    C.CourseName;
                        --29
SELECT 
    E.EmployeeName, 
    D.DepartmentName
FROM 
Employees E
LEFT JOIN 
Departments D
ON 
E.DepartmentID = D.DepartmentID
WHERE 
D.DepartmentName = 'Marketing';
                        --30
SELECT 
    O.OrderID, 
    P.ProductName
FROM 
    Orders O
JOIN 
    Products P
ON 
    O.Quantity <= P.StockQuantity;
	EXEC sp_help 'Products';
