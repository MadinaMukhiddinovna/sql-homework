Puzzle 1: Extract month with zero-padding

SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR), 2) AS MonthPrefixedWithZero
FROM Dates;

Puzzle 2: Distinct Id count and sum of max Vals per Id and rID

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) AS sub
GROUP BY rID;

Puzzle 3: Strings with length between 6 and 10

SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

Puzzle 4: Get item with max value per ID (single SELECT)

SELECT t.*
FROM TestMaximum t
JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaximum
    GROUP BY ID
) m ON t.ID = m.ID AND t.Vals = m.MaxVal;


Puzzle 5: Sum of max Vals per DetailedNumber per Id (single SELECT)

SELECT Id, SUM(MaxVal) AS SumOfMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS sub
GROUP BY Id;

Puzzle 6: Difference (a - b), show blank if zero

SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b = 0 THEN ''
        ELSE CAST(a - b AS VARCHAR)
    END AS OUTPUT
FROM TheZeroPuzzle; 

 ---7.Total revenue generated from all sales

SELECT SUM(SellingPrice * Quantity) AS TotalRevenue
FROM Sales;

---8. Average unit price of products

SELECT AVG(SellingPrice) AS AverageUnitPrice
FROM Products;

---9. Number of sales transactions recorded

SELECT COUNT(*) AS TotalSalesTransactions
FROM Sales;

---10. Highest number of units sold in a single transaction

SELECT MAX(Quantity) AS MaxUnitsSold
FROM Sales;

---11. Number of products sold in each category

SELECT P.Category, SUM(S.Quantity) AS TotalProductsSold
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category;

--12. Total revenue for each region

SELECT C.Region, SUM(S.SellingPrice * S.Quantity) 
AS TotalRevenue
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.Region;

---13. Total quantity sold per month

SELECT MONTH(S.SaleDate) AS SaleMonth, SUM(S.Quantity) 
AS TotalQuantitySold
FROM Sales S
GROUP BY MONTH(S.SaleDate)
ORDER BY SaleMonth;

--14. Which product generated the highest total revenue?

SELECT P.ProductName, SUM(S.SellingPrice * S.Quantity) 
AS TotalRevenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC
LIMIT 1;

---15. Running total of revenue ordered by sale date

SELECT 
    S.SaleDate,
    SUM(S.SellingPrice * S.Quantity) OVER (ORDER BY S.SaleDate) 
	AS RunningTotalRevenue
FROM Sales S;

--16. Category contribution to total sales revenue

SELECT 
    P.Category,
    SUM(S.SellingPrice * S.Quantity) AS TotalRevenue,
    (SUM(S.SellingPrice * S.Quantity) / (SELECT SUM(SellingPrice * Quantity) FROM Sales)) * 100 
	AS RevenuePercentage
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category;

---17. Show all sales along with the corresponding customer names

SELECT S.SaleID, S.SaleDate, C.CustomerName, S.ProductID, S.Quantity, S.SellingPrice
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID;

---18. List customers who have not made any purchases

SELECT C.CustomerName
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
WHERE S.CustomerID IS NULL;

---19. Compute total revenue generated from each customer

SELECT C.CustomerName, SUM(S.SellingPrice * S.Quantity) AS TotalRevenue
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName;

---20. Find the customer who has contributed the most revenue

SELECT TOP 1 C.CustomerName, SUM(S.SellingPrice * S.Quantity) AS TotalRevenue
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalRevenue DESC;

---21. Calculate the total sales per customer per month

SELECT 
    C.CustomerName,
    MONTH(S.SaleDate) AS SaleMonth,
    SUM(S.SellingPrice * S.Quantity) AS TotalSales
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
GROUP BY C.CustomerName, MONTH(S.SaleDate)
ORDER BY C.CustomerName, SaleMonth;

----22. List all products that have been sold at least once

SELECT DISTINCT P.ProductName
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID;

-----23. Find the most expensive product in the Products table

SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

----24. Show each sale with its corresponding cost price from the Products table

SELECT S.SaleID, S.SaleDate, P.ProductName, S.Quantity, P.CostPrice, S.SellingPrice
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID;

----25. Find all products where the selling price is higher than the average selling price in their category

SELECT P.ProductName, P.SellingPrice, P.Category
FROM Products P
WHERE P.SellingPrice > 
    (SELECT AVG(SellingPrice) 
     FROM Products 
     WHERE Category = P.Category);
