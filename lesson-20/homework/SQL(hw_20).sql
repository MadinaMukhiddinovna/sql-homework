--1. Find customers who purchased at least one item in March 2024 using EXISTS

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3 AND YEAR(s2.SaleDate) = 2024
);

--2. Find the product with the highest total sales revenue using a subquery.

SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

--3. Find the second highest sale amount using a subquery

SELECT MAX(TotalSale) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS TotalSale
    FROM #Sales
) AS SalesAmounts
WHERE TotalSale < (
    SELECT MAX(Quantity * Price) FROM #Sales
);


--4. Find the total quantity of products sold per month using a subquery

SELECT MONTH(SaleDate) AS SaleMonth, SUM(Quantity) AS TotalQuantity
FROM #Sales
GROUP BY MONTH(SaleDate);

--5. Find customers who bought same products as another customer using EXISTS

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.Product = s1.Product
      AND s2.CustomerName <> s1.CustomerName
);
--6. Return how many fruits does each person have in individual fruit level

SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

--7. Return older people in the family with younger ones

WITH Ancestors AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentId, a.ChildID
    FROM Family f
    JOIN Ancestors a ON f.ChildID = a.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM Ancestors
ORDER BY PID, CHID;

--8. For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas

SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders
      WHERE CustomerID = o.CustomerID
        AND DeliveryState = 'CA'
  );

--9. Insert the names of residents if they are missing

UPDATE #residents
SET fullname = fullname + ' name=' + 
    SUBSTRING(address, CHARINDEX('name=', address) + 5, 
              CHARINDEX(' age=', address) - CHARINDEX('name=', address) - 5)
WHERE fullname NOT LIKE '% %' AND CHARINDEX('name=', address) > 0;

--10. Return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes

WITH RoutesCTE AS (
    SELECT DepartureCity, ArrivalCity, Cost, 
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT r.DepartureCity, r.ArrivalCity, c.Cost + r.Cost,
           CAST(c.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX))
    FROM #Routes r
    JOIN RoutesCTE c ON r.DepartureCity = c.ArrivalCity
    WHERE c.Route NOT LIKE '%' + r.ArrivalCity + '%'
)
SELECT Route, Cost
FROM RoutesCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;

--11. Rank products based on their order of insertion.

WITH Ranked AS (
    SELECT *, 
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS Rank
    FROM #RankingPuzzle
)
SELECT ID, Vals, Rank
FROM Ranked;

--12. Return Ids, what number of the letter would be next if inserted, the maximum length of the consecutive occurrence of the same digit

WITH CTE AS (
    SELECT Id, Vals,
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS rn
    FROM #Consecutives
),
Grouped AS (
    SELECT Id, Vals, rn - 
           ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY rn) AS grp
    FROM CTE
),
MaxConsecutive AS (
    SELECT Id, Vals, COUNT(*) AS cnt
    FROM Grouped
    GROUP BY Id, Vals, grp
)
SELECT Id, Vals, MAX(cnt) AS MaxConsecutive
FROM MaxConsecutive
GROUP BY Id, Vals;

--13. Find employees whose sales are above the department average

SELECT e.EmployeeID, e.Name, s.Amount, e.DepartmentID
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.Amount > (
    SELECT AVG(s2.Amount)
    FROM Sales s2
    JOIN Employees e2 ON s2.EmployeeID = e2.EmployeeID
    WHERE e2.DepartmentID = e.DepartmentID
);

--14. Find departments with more than 3 employees

SELECT DepartmentID
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 3;

--15. Find products that were never sold

SELECT p.ProductID, p.ProductName
FROM Products p
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales s
    WHERE s.ProductID = p.ProductID
);

--16. Find the last sale date for each product

SELECT s.ProductID, MAX(s.SaleDate) AS LastSaleDate
FROM Sales s
GROUP BY s.ProductID;

--17. Find months with no sales

WITH AllMonths AS (
    SELECT 1 AS MonthNum UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
)
SELECT MonthNum
FROM AllMonths m
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales s
    WHERE MONTH(s.SaleDate) = m.MonthNum
);

--18. Find the customer with the most purchases

SELECT TOP 1 CustomerID, COUNT(*) AS NumSales
FROM Sales
GROUP BY CustomerID
ORDER BY NumSales DESC;

--19. Find top-3 products by total revenue

SELECT TOP 3 ProductID, SUM(Quantity * Price) AS TotalRevenue
FROM Sales
GROUP BY ProductID
ORDER BY TotalRevenue DESC;

--20. Find employees with no sales

SELECT e.EmployeeID, e.Name
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.EmployeeID IS NULL;

--21. Find the average sales amount per department

SELECT e.DepartmentID, AVG(s.Amount) AS AvgSale
FROM Employees e
JOIN Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.DepartmentID;

--22. Find employees with the earliest and latest sale

-- Earliest sale
SELECT TOP 1 EmployeeID, SaleDate
FROM Sales
ORDER BY SaleDate ASC;

-- Latest sale
SELECT TOP 1 EmployeeID, SaleDate
FROM Sales
ORDER BY SaleDate DESC;

--first query = employee with the earliest sale
--query = employee with the latest sale

--23. Find products sold to more than one customer

SELECT ProductID
FROM Sales
GROUP BY ProductID
HAVING COUNT(DISTINCT CustomerID) > 1;

--24. Find number of sales for each weekday

SELECT DATENAME(WEEKDAY, SaleDate) AS WeekDay, COUNT(*) AS SalesCount
FROM Sales
GROUP BY DATENAME(WEEKDAY, SaleDate);

--25. Find customers who bought all products

SELECT s.CustomerID
FROM Sales s
GROUP BY s.CustomerID
HAVING COUNT(DISTINCT s.ProductID) = (SELECT COUNT(*) FROM Products);
