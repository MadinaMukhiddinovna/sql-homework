  create database homework_14;
  use homework_14;
  
  ---CTEs and Derived Tables

  --1.Create a numbers table using a recursive query

  WITH Numbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1 FROM Numbers WHERE Number < 10
)
SELECT * FROM Numbers;

---Generate numbers from 1 to 10 using recursion 

--2.Dounble the number for each record using recursion 

WITH Doubled AS (
SELECT 1 AS Num 
UNION ALL 
SELECT Num  * 2 FROM Doubled WHERE  Num < 100 
) 
SELECT * FROM Doubled;   

---Start from 1 and keep doubling until under 100 

--3.Total sales per employee using a derived table 

SELECT EmployeeID, TotalSales
FROM (
    SELECT EmployeeID, SUM(SaleAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS SalesPerEmployee;

---Use a derived table to sum sales per employee

 --4.CTE to find the average salary

WITH AvgSal AS (
		SELECT AVG(Salary) AS AvgSalary 
		FROM Employees
		) 
		SELECT * FROM Employees 
		WHERE Salary > (SELECT AvgSalary FROM AvgSal);

---Use cte to compare salaries to the average
 
 --5.Derived table for highest sales per product

 SELECT ProductID, MAX(TotalSales) AS MaxSale
 FROM ( 
	 SELECT ProductID, SUM(SaleAmount) as TotalSales
	 FROM Sales 
	 GROUP BY ProductID
	 ) as ProductSales
	 GROUP BY ProductID;

---Use a derived table to get total sales, then max per product

--6.CTE: employees with more than 5 sales 

WITH SaleCounts AS (
	SELECT EmployeeID, COUNT(*) AS SaleCount 
	FROM Sales
	GROUP BY EmployeeID
	)
	SELECT e.Name 
	FROM Employees e 
	JOIN SaleCounts sc ON e.EmployeeID = sc.EmployeeID
	WHERE sc.SaleCount > 5;

---Find employees who made more than 5 sales

--7.CTE: products with sales > $500

WITH ProductSales AS (
	SELECT ProductID, SUM(SaleAmount) AS Total
	FROM Sales 
	GROUP BY ProductID
	)
	SELECT * FROM ProductSales
	WHERE Total > 500

---Filter products with sales above $500

--8.CTE: epmloyees with salary above average 

WITH AvgSalary AS (
	SELECT AVG(Salary) AS Avg FROM Employees
)
 SELECT * FROM Employees 
 WHERE Salary > (SELECT Avg FROM AvgSalary);

 ---Compare salaries to average using a CTE

 --9.Derived table: total products sold

 SELECT SUM(TotalQty) AS ALLProductsSold
 FROM (
	SELECT ProductID, SUM(Quantity) AS TotalQty
	FROM Sales 
	GROUP BY ProductID
	) AS ProductTotal;

---USE a derived table to sum all product quantities

--10.CTE: employees with no sales 

WITH SalesMade AS (
	SELECT DISTINCT EmployeeID 
	FROM Sales
	)
	SELECT * FROM Employees
	WHERE EmployeeID not in (SELECT EmployeeID from SalesMade);

---Find employees who didn't make any sales

----------MEDIUM TASKS-------

--1.Recursion to calculate factorials

WITH Factorial AS (
	SELECT 1 AS Num, 1 AS Fact
	UNION ALL
	SELECT Num + 1, Fact * (Num + 1)
	FROM Factorial
	WHERE Num < 5 
	)
	SELECT * FROM Factorial;
---Recursive factorials from 1 to 5 

--2.Recursion to generate Fibonacci numbers

WITH Fibonacci AS (
	SELECT 0 AS n, 0 AS val
	UNION ALL
	SELECT 1 AS n, 1 AS val
	UNION ALL
	SELECT n + 1, prev.val + curr.val
	FROM Fibonacci prev
	JOIN Fibonacci curr ON prev.n = curr.n - 1
	WHERE curr.n < 10
	)
	SELECT * FROM Fibonacci;

---simple recursion to make Fibonacci series

--3.Split a string into rows using recursion

DECLARE @str varchar(100) = 'abc';
WITH Chars AS (
	SELECT 1 AS Pos, SUBSTRING(@str, 1, 1) as Chr
	UNION ALL 
	SELECT Pos + 1, SUBSTRING(@str, Pos + 1, 1)
	FROM Chars
	WHERE Pos < LEN(@str)
	)
	SELECT * FROM Chars;

---split each character into its own row

--4.CTE to rank employees by sales

WITH EmpSales AS (
	SELECT EmployeeID, SUM(SaleAmount) AS TotalSales
	FROM Sales
	GROUP BY EmployeeID
	)
	SELECT *, RANK() OVER (ORDER BY TotalSales DESC) AS RANK
	FROM EmpSales;

---rank employees by their total sales
 
 --5.Top 5 employees by orderes (derived table)

 SELECT TOP 5 EmployeeID, COUNT (*) AS OrderCount 
 FROM Sales 
 GROUP BY EmployeeID
 ORDER BY OrderCount DESC;

 ---get top 5 Employees by orders (derived table)

 --6.CTE: sales difference between months

	WITH MonthlySales AS (
    SELECT MONTH(SaleDate) AS MonthNum, SUM(SaleAmount) AS MonthlyTotal
    FROM Sales
    GROUP BY MONTH(SaleDate)
)
SELECT MonthNum, MonthlyTotal - LAG(MonthlyTotal) OVER (ORDER BY MonthNum) AS SalesDiff
FROM MonthlySales;

--7.Derived table: sales per category

SELECT p.CategoryID, SUM(s.SaleAmount) AS TotalSales 
FROM (
	SELECT ProductID, SaleAmount FROM Sales
	) s 
	JOIN Products p ON s.ProductID = p.ProductID
	GROUP BY p.CategoryID;

---group  sales by product category

--8.CTE: rank products by sales last year

WITH LastYearSales AS (
	SELECT ProductID, SUM(SaleAmount) AS Total
	FROM Sales
	WHERE SaleDate >= DATEADD(YEAR, -1, GETDATE())
	GROUP BY ProductID
	)
	SELECT *, RANK() OVER (ORDER BY Total DESC) AS Rank FROM LastYearSales;
	
	---rank products sold last year by amount

--9.Derived table: employees with $5000+ sales per quarter

SELECT * FROM (
	SELECT EmployeeID, DATEPART(QUARTER, SaleDate) AS Quarter, SUM(SaleAmount) as Total
	FROM Sales
	GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
	) q 
	WHERE q.Total > 5000;
	
	---show employees with over $5,000 in any quarter

	--10.Derived table: top3 employees by monthly sales
	SELECT TOP 3 EmployeeID, SUM(SaleAmount) AS Total 
	FROM Sales
	WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
	GROUP BY EmployeeID
	ORDER BY Total desc;

---top 3 employees last month by sales

----------DIFFICULT TASKS--------

--1.Numbers like: 1, 12, 123, 1234, 12345

WITH NumSeq AS (
    SELECT 1 AS N, CAST('1' AS VARCHAR(MAX)) AS Seq
    UNION ALL
    SELECT N + 1, Seq + CAST(N + 1 AS VARCHAR)
    FROM NumSeq
    WHERE N < 5
)
SELECT * FROM NumSeq;

---generate pattern 1 => 12 => 123... using recursion

--2.Most sales in last 6 months

SELECT TOP 1 EmployeeID, SUM(SaleAmount) AS Total
FROM Sales
WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY EmployeeID
ORDER BY Total DESC; 

---get the employee with most sales in last 6 months

--3.Running total not more than 10 or less than 0

WITH Running AS (
    SELECT 1 AS Step, 5 AS Total
    UNION ALL
    SELECT Step + 1, 
        CASE 
            WHEN Total + 2 > 10 THEN 10
            WHEN Total - 2 < 0 THEN 0
            ELSE Total + 2
        END
    FROM Running
    WHERE Step < 5
)
SELECT * FROM Running;

---add 2 each step but limit to 0–10

--4.Merge schedules and limit to 0-10

SELECT s.EmployeeID, s.TimeSlot, 
       ISNULL(a.Activity, 'Work') AS Status
FROM Schedule s
LEFT JOIN Activity a 
  ON s.EmployeeID = a.EmployeeID AND s.TimeSlot = a.TimeSlot;
  
 --If no activity exists, label as "Work"

--5.CTE + derived: department + product sales

WITH DeptSales AS (
    SELECT e.DepartmentID, s.ProductID, SUM(s.SaleAmount) AS Total
    FROM Sales s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.DepartmentID, s.ProductID
)
SELECT * FROM (
    SELECT DepartmentID, ProductID, Total FROM DeptSales
) AS CombinedSales;

---combine employee dept + product sales using both CTE and derived table
