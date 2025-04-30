-----1. Running Total Sales per Customer

SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;

-----2. Count the Number of Orders per Product Category

SELECT product_category, COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

----3. Maximum Total Amount per Product Category

SELECT product_category, MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;

----4. Minimum Price of Products per Product Category

SELECT product_category, MIN(unit_price) AS min_unit_price
FROM sales_data
GROUP BY product_category;

----5. Moving Average of Sales of 3 Days (prev, current, next)

SELECT order_date, total_amount,
       ROUND(AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS moving_avg_3days
FROM sales_data
ORDER BY order_date;

----6. Total Sales per Region

SELECT region, SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

----7. Rank of Customers Based on Their Total Purchase Amount

SELECT customer_id, customer_name,
       SUM(total_amount) AS total_purchase,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS purchase_rank
FROM sales_data
GROUP BY customer_id, customer_name;

----8. Difference Between Current and Previous Sale Amount per Customer

SELECT customer_id, customer_name, order_date, total_amount,
       total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS amount_difference
FROM sales_data
ORDER BY customer_id, order_date;

----9. Top 3 Most Expensive Products in Each Category

SELECT *
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS price_rank
    FROM sales_data
) ranked
WHERE price_rank <= 3;

---10. Cumulative Sum of Sales Per Region by Order Date

SELECT region, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;

----11. Cumulative Revenue per Product Category

SELECT product_category, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;

----12. Sum of Previous Values (ID)

SELECT ID, 
       SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM (
    SELECT 1 AS ID UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 UNION ALL
    SELECT 5
) AS T;
----13. Sum of Previous Values (OneColumn)

SELECT Value,
       SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;

----14. Row Number with First Row as Odd for Each Group

WITH Numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
    FROM Row_Nums
),
OddStart AS (
    SELECT *, rn + (Id * 2 - 1) - 1 AS RowNumber
    FROM Numbered
)
SELECT Id, Vals, DENSE_RANK() OVER (ORDER BY RowNumber) AS RowNumber
FROM OddStart;

----15. Find Customers Who Purchased Items from More Than One Product Category

SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT ProductCategory) > 1;

----16. Find Customers with Above-Average Spending in Their Region

SELECT CustomerID, SUM(Amount) AS TotalSpending
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > (
    SELECT AVG(TotalSpending)
    FROM (
        SELECT CustomerID, SUM(Amount) AS TotalSpending
        FROM Orders
        GROUP BY CustomerID
    ) AS avg_spending
);

----17. Rank Customers Based on Total Spending (Dense Ranking)

SELECT CustomerID, 
       SUM(Amount) AS TotalSpending,
       DENSE_RANK() OVER (ORDER BY SUM(Amount) DESC) AS Rank
FROM Orders
GROUP BY CustomerID;

----18. Calculate Running Total of Total Amount for Each Customer (Ordered by Order Date)

SELECT CustomerID, OrderDate, 
       SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) 
	   AS CumulativeSales
FROM SalesData;

----19. Calculate Sales Growth Rate for Each Month Compared to the Previous Month

WITH MonthlySales AS (
    SELECT MONTH(OrderDate) AS Month, YEAR(OrderDate)
	AS Year, SUM(TotalAmount) AS TotalSales
    FROM SalesData
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
)
SELECT Month, Year, TotalSales, 
       LAG(TotalSales) OVER (ORDER BY Year, Month) AS PreviousMonthSales,
       (TotalSales - LAG(TotalSales) OVER (ORDER BY Year, Month)) / LAG(TotalSales) 
	   OVER (ORDER BY Year, Month) * 100 AS GrowthRate
FROM MonthlySales;

----20. Identify Customers Whose Total Amount is Higher Than Their Last Order's Total Amount

WITH LastOrder AS (
    SELECT CustomerID, MAX(OrderDate) AS LastOrderDate
    FROM Orders
    GROUP BY CustomerID
)
SELECT o.CustomerID
FROM Orders o
JOIN LastOrder lo ON o.CustomerID = lo.CustomerID
WHERE o.OrderDate = lo.LastOrderDate
AND o.TotalAmount > (
    SELECT MAX(TotalAmount)
    FROM Orders
    WHERE CustomerID = o.CustomerID
    AND OrderDate < lo.LastOrderDate
);
----21. Identify Products with Prices Above the Average Product Price

SELECT ProductID, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

----22. Sum of Val1 and Val2 for Each Group (Single Select)

SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
            THEN (SELECT SUM(Val1 + Val2) FROM MyData WHERE Grp = MyData.Grup)
            ELSE NULL
       END AS Tot
FROM MyData;

-----23. Sum of Cost and Quantity for Each ID (Handling Different Quantities)

SELECT Id, 
       SUM(Cost) AS Cost, 
       SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY Id;

----24. Sum of TyZe for Each Z Level

WITH Summed AS (
    SELECT Level, TyZe, Result,
           SUM(TyZe) OVER (PARTITION BY Result ORDER BY Level) AS Results
    FROM testSuXVI
)
SELECT Level, TyZe, Result, Results
FROM Summed;

----25. Row Numbers with First Row as Even Number for Each Partition

WITH Numbered AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
    FROM Row_Nums
)
SELECT Id, Vals, rn + (Id * 2 - 2) AS Changed
FROM Numbered;
