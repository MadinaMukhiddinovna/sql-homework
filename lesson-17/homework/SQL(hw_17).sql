 use hometasks_17;

--1.List items with price > average price

SELECT * 
FROM Items
WHERE Price > (
    SELECT AVG(Price) 
	FROM Items
);

-- Returns items priced above the average

--2. Staff in divisions with more than 10 people

SELECT * 
FROM Staff
WHERE DivisionID IN (
    SELECT DivisionID 
    FROM Staff 
    GROUP BY DivisionID 
    HAVING COUNT(*) > 10
);
-- Selects staff from divisions with more than 10 employee

--3. Staff with salary > avg in their division

SELECT * 
FROM Staff s1
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM Staff s2 
    WHERE s2.DivisionID = s1.DivisionID
);
-- Compares salary with average salary of the same division

--4. Clients who made a purchase

SELECT * 
FROM Clients
WHERE ClientID IN (
    SELECT DISTINCT ClientID 
    FROM Purchases
);

-- Shows clients who appear in Purchases table

--5. Purchases that include at least one detail

SELECT * 
FROM Purchases p
WHERE EXISTS (
    SELECT 1 
    FROM PurchaseDetails pd 
    WHERE pd.PurchaseID = p.PurchaseID
);

-- Uses EXISTS to find purchases with related details

--6. Items sold more than 100 times

SELECT * FROM Items
WHERE ItemID IN (
    SELECT ItemID 
	FROM PurchaseDetails
    GROUP BY ItemID
    HAVING SUM(Quantity) > 100
);
-- Sums quantity sold from PurchaseDetails for each item

--7. Staff earning above company average

SELECT * FROM Staff
WHERE Salary > (SELECT AVG(Salary) 
FROM Staff);

-- Compares each staff salary to company average

--8. Vendors supplying items priced below $50

SELECT DISTINCT VendorID 
FROM Items
WHERE Price < 50;

-- Gets vendors with cheap item supplies

--9. Maximum item price

SELECT MAX(Price) AS MaxPrice 
FROM Items;

-- Simple max aggregation to get highest item price

--10. Highest total purchase value

SELECT MAX(Total) AS MaxPurchaseValue 
FROM (
    SELECT PurchaseID, SUM(Quantity * Price) AS Total
    FROM PurchaseDetails pd
    JOIN Items i ON pd.ItemID = i.ItemID
    GROUP BY PurchaseID
) AS PurchaseTotals;

-- Subquery calculates total per purchase

--11. Clients who never made a purchase

SELECT * FROM Clients
WHERE ClientID NOT IN (
    SELECT DISTINCT ClientID 
	FROM Purchases
);
-- Clients not found in the Purchases table

--12. Items in "Electronics" category

SELECT * 
FROM Items
WHERE CategoryID = (
    SELECT CategoryID 
    FROM Categories 
    WHERE CategoryName = 'Electronics'
);
--maps category name to ID using subquery

--13. Purchases after specific date

SELECT * 
FROM Purchases
WHERE PurchaseDate > (
    SELECT '2024-01-01'
);

--simple date comparison with literal subquery

--14. Total items sold in a purchase

SELECT SUM(Quantity) AS TotalSold 
FROM PurchaseDetails
WHERE PurchaseID = (
    SELECT PurchaseID 
    FROM Purchases 
    WHERE PurchaseID = 1
);

--returns total items sold in one purchas

--15. Staff employed more than 5 years

SELECT * 
FROM Staff
WHERE HireDate < (
    SELECT DATEADD(YEAR, -5, GETDATE())
);

-- Checks if hire date is older than 5 years ago

--16. Staff earning more than avg in division (correlated)

SELECT * FROM Staff S1
WHERE Salary > (
    SELECT AVG(Salary) 
	FROM Staff S2
    WHERE S1.DivisionID = S2.DivisionID
);

-- Repeats similar to Task 3, uses correlation

--17. Purchases that include an item

SELECT * FROM Purchases p
WHERE EXISTS (
    SELECT 1 
	FROM PurchaseDetails pd
    WHERE PD.PurchaseID = P.PurchaseID
    AND PD.ItemID IN (SELECT ItemID FROM Items)
);
-- Ensures item exists in the purchase

--18. Clients who purchased in last 30 days

SELECT * 
FROM Clients
WHERE ClientID IN (
    SELECT ClientID 
    FROM Purchases 
    WHERE PurchaseDate >= DATEADD(DAY, -30, GETDATE())
);
--filters recent buyers by date

--19. Oldest item

SELECT * 
FROM Items
WHERE CreatedDate = (
    SELECT MIN(CreatedDate) 
	FROM Items
);
--gets the item with earliest creation date

--20. Staff not assigned to any division

SELECT * 
FROM Staff
WHERE DivisionID IS NULL 
   OR DivisionID NOT IN (
       SELECT DivisionID 
	   FROM Divisions
);
--staff with missing or invalid division

---------------------------------------------------------------------------------

--1.List clients who made more purchases than the average number of purchases per client

SELECT ClientID
FROM Purchases
GROUP BY ClientID 
HAVING COUNT(*) > (
	SELECT AVG(PurchaseCount)
	FROM (
	SELECT ClientID, COUNT(*) AS PurchaseCount
	FROM Purchases
	GROUP BY ClientID
	) AS Sub
	);

--select clients whose count is above average

--2.Find items whose price is higher than the most expensive item in category 'Accessories'

SELECT *
FROM Items
WHERE Price > (
	SELECT MAX(Price)
	FROM Items 
	WHERE CategoryID = (
		SELECT CategoryID 
		FROM Categories 
		WHERE CategoryName = 'Accessories'
	)
);

--compares item price to max price in a specific category

--3.List divisions with average salary higher than overall average salary

SELECT DivisionID
FROM Staff
GROUP BY DivisionID
HAVING AVG(Salary) > (
	SELECT AVG(Salary) 
	FROM Staff
	);

--filters divisions by salary average  comparison

--4.Show items never purchased

SELECT *
FROM Items
WHERE ItemID NOT IN ( 
	 SELECT DISTINCT ItemID 
	 FROM PurchaseDetails
	 );

--find items with no sales record 

--5.Get purchases with total value above the average purchase value

SELECT PurchaseID, SUM(Quantity * Price) AS Total 
FROM PurchaseDetails pd 
JOIN Items i ON pd.ItemID = i.ItemID 
GROUP BY PurchaseID 
HAVING SUM(Quantity * Price) > (
	SELECT AVG(Total)
	FROM (
		SELECT SUM(Quantity * Price) AS Total
		FROM PurchaseDetails pd2
		JOIN Items i2 ON pd2.ItemID = i2.ItemID
		GROUP BY pd2.PurchaseID
		) AS Sub
	);

--selects high-value purchases compared to the average

--6.List vendors supplying the cheapest item 

SELECT VendorID
FROM Items 
WHERE Price = (
	SELECT MIN(Price) 
	FROM Items
);

--returns vendors with the absolute cheapest item

--7.Show staff who earn the highest salary in their division 

SELECT *
FROM Staff s1
WHERE Salary = ( 
	 SELECT MAX(Salary) 
	 FROM Staff s2
	 WHERE s2.DivisionID = s1.DivisionID
	);

--staff with top salary in their division

--8.Find the most popular item (sold most times)

SELECT ItemID
FROM PurchaseDetails
GROUP BY ItemID 
HAVING SUM(Quantity) = (
	SELECT MAX(TotalSold)
	FROM (
		 SELECT SUM(Quantity) AS TotalSold
		 FROM PurchaseDetails
		 GROUP BY ItemID
	) AS Sub 
);
--find the best-selling items

--9.List categories that contain more than 5 items

SELECT Categories 
FROM Items
GROUP BY CategoryID
HAVING COUNT(*) > 5;

--where categoryID in select categoryID..

--10.Find items that are cheaper than the average in their category

SELECT *
FROM Items i1 
WHERE Price < (
	SELECT AVG(Price)
	FROM Items i2 
	WHERE  i2.CategoryID = i1.CategoryID
);

--Compares item price with category average.

--11.List staff who joined later than the average hire date

SELECT * 
FROM Staff 
WHERE HireDate > (
	SELECT AVG(CAST(HireDate AS FLOAT)) FROM Staff
);

--converts date to float for average calculation

--12.Show purchases where more than 3 different items were bought

SELECT PurchaseID
FROM PurchaseDetails 
GROUP BY PurchaseID 
HAVING COUNT(DISTINCT ItemID) > 3;

--filters purchases by item diversity

--13.List items sold only once 

SELECT * 
FROM Items
WHERE ItemID IN (
	SELECT ItemID
	FROM PurchaseDetails
	GROUP BY ItemID
	HAVING SUM(Quantity) = 1
);

--rarely sold items

--14.Get the average number of items per purchase

SELECT AVG(ItemCount) AS AvgItems
FROM (
	SELECT PurchaseID, SUM(Quantity) AS ItemCount
	FROM PurchaseDetails
	GROUP BY PurchaseID
)  AS Sub;

--uses subquery to count items per purchase

--15.Find divisions where all staff earn above 3000

SELECT DivisionID
FROM Staff 
GROUP BY DivisionID
HAVING MIN(Salary) > 3000;

--ensures no one earns less than 3000

--16.List categories with total sales more than 1000

 SELECT CategoryID
 FROM Items i 
 JOIN PurchaseDetails pd ON i.ItemID = pd.ItemID
 GROUP BY CategoryID
 HAVING SUM(pd.Quantity * i.Price) > 1000; 
  
  --total sales by category

  --17.List items sold in every month of 2024

 SELECT ItemID 
FROM PurchaseDetails pd
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
WHERE YEAR(p.PurchaseDate) = 2024
GROUP BY ItemID
HAVING COUNT(DISTINCT MONTH(p.PurchaseDate)) = 12;

--checks if item appears in all months

--18.Clients whose total spend exceeds the average spend 

SELECT ClientID 
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
GROUP BY ClientID
HAVING SUM(Quantity * Price) > (
    SELECT AVG(Total) 
    FROM (
        SELECT ClientID, SUM(Quantity * Price) AS Total
        FROM Purchases p2
        JOIN PurchaseDetails pd2 ON p2.PurchaseID = pd2.PurchaseID
        JOIN Items i2 ON pd2.ItemID = i2.ItemID
        GROUP BY ClientID
    ) AS Sub
);
--high-spending clients

--19.List staff who are not managers of any division

SELECT * 
FROM Staff 
WHERE StaffID NOT IN (
		SELECT ManagerID
		FROM Divisions 
		WHERE ManagerID IS NOT NULL
);
--excludes staff who manage a division

--20.Find the 2nd highest priced item 

SELECT MAX(Price)
FROM Items
WHERE Price < (
	SELECT MAX(Price) 
	FROM Items
);

--second highest price using nested subquery

------------------------------------------------------------------------------

-- 1. Staff earning more than average in their division, excluding top earner
SELECT s1.*
FROM Staff s1
WHERE s1.Salary > (
    SELECT AVG(s2.Salary)
    FROM Staff s2
    WHERE s2.DivisionID = s1.DivisionID
      AND s2.StaffID NOT IN (
          SELECT TOP 1 s3.StaffID
          FROM Staff s3
          WHERE s3.DivisionID = s1.DivisionID
          ORDER BY s3.Salary DESC
      )
);

-- 2. Items bought by clients with more than 5 orders
SELECT * FROM Items
WHERE ItemID IN (
    SELECT DISTINCT pd.ItemID
    FROM PurchaseDetails pd
    JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
    WHERE p.ClientID IN (
        SELECT ClientID FROM Purchases
        GROUP BY ClientID
        HAVING COUNT(*) > 5
    )
);

-- 3. Staff older than avg age and earning above avg salary
SELECT * FROM Staff
WHERE Age > (SELECT AVG(Age) FROM Staff)
  AND Salary > (SELECT AVG(Salary) FROM Staff);

-- 4. Staff in divisions with more than 5 staff earning > 100k
SELECT * FROM Staff s1
WHERE s1.DivisionID IN (
    SELECT s2.DivisionID
    FROM Staff s2
    WHERE s2.Salary > 100000
    GROUP BY s2.DivisionID
    HAVING COUNT(*) > 5
);

-- 5. Items not purchased in past year
SELECT * FROM Items
WHERE ItemID NOT IN (
    SELECT DISTINCT pd.ItemID
    FROM PurchaseDetails pd
    JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
    WHERE p.PurchaseDate >= DATEADD(YEAR, -1, GETDATE())
);

-- 6. Clients who bought items from 2+ categories
SELECT * FROM Clients
WHERE ClientID IN (
    SELECT p.ClientID
    FROM Purchases p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    GROUP BY p.ClientID
    HAVING COUNT(DISTINCT i.Category) >= 2
);

-- 7. Staff earning more than average in their position
SELECT * FROM Staff s1
WHERE s1.Salary > (
    SELECT AVG(s2.Salary)
    FROM Staff s2
    WHERE s2.Position = s1.Position
);

-- 8. Items in top 10% by price
SELECT * FROM Items
WHERE Price >= (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Price) FROM Items
);

-- 9. Staff with salary in top 10% within division
SELECT * FROM Staff s1
WHERE s1.Salary >= (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY s2.Salary)
    FROM Staff s2
    WHERE s2.DivisionID = s1.DivisionID
);

-- 10. Staff with no bonus in last 6 months
SELECT * FROM Staff
WHERE StaffID NOT IN (
    SELECT StaffID FROM Bonuses
    WHERE BonusDate >= DATEADD(MONTH, -6, GETDATE())
);

-- 11. Items ordered more than avg order per item
SELECT * FROM Items i
WHERE (
    SELECT COUNT(*) FROM PurchaseDetails pd WHERE pd.ItemID = i.ItemID
) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) as cnt FROM PurchaseDetails GROUP BY ItemID
    ) as sub
);

-- 12. Clients who purchased last year items above avg price
SELECT * FROM Clients
WHERE ClientID IN (
    SELECT p.ClientID
    FROM Purchases p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    WHERE p.PurchaseDate BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
      AND i.Price > (SELECT AVG(Price) FROM Items)
);

-- 13. Division with highest avg salary
SELECT TOP 1 DivisionID
FROM Staff
GROUP BY DivisionID
ORDER BY AVG(Salary) DESC;

-- 14. Items purchased by clients with more than 10 orders
SELECT * FROM Items
WHERE ItemID IN (
    SELECT DISTINCT pd.ItemID
    FROM PurchaseDetails pd
    JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
    WHERE p.ClientID IN (
        SELECT ClientID FROM Purchases
        GROUP BY ClientID
        HAVING COUNT(*) > 10
    )
);

-- 15. Staff in division with highest total sales
SELECT * FROM Staff s
WHERE s.DivisionID = (
    SELECT TOP 1 s2.DivisionID
    FROM Staff s2
    JOIN Purchases p ON s2.StaffID = p.StaffID
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    GROUP BY s2.DivisionID
    ORDER BY SUM(i.Price * pd.Quantity) DESC
);

-- 16. Staff with salary in top 5% company-wide
SELECT * FROM Staff
WHERE Salary >= (
    SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Salary) FROM Staff
);

-- 17. Items not purchased in past month
SELECT * FROM Items
WHERE ItemID NOT IN (
    SELECT DISTINCT pd.ItemID
    FROM PurchaseDetails pd
    JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
    WHERE p.PurchaseDate >= DATEADD(MONTH, -1, GETDATE())
);

-- 18. Staff in division with highest purchase totals
SELECT * FROM Staff s
WHERE s.DivisionID IN (
    SELECT TOP 1 s2.DivisionID
    FROM Purchases p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Staff s2 ON s2.StaffID = p.StaffID
    GROUP BY s2.DivisionID
    ORDER BY SUM(pd.Quantity * (SELECT Price FROM Items WHERE Items.ItemID = pd.ItemID)) DESC
);

-- 19. Clients inactive for 6 months and spent < $100

SELECT *
FROM Clients c
WHERE c.ClientID NOT IN (
    SELECT DISTINCT p.ClientID
    FROM Purchases p
    WHERE p.PurchaseDate >= DATEADD(MONTH, -6, GETDATE())
)
AND (
    SELECT ISNULL(SUM(pd.Quantity * i.Price), 0)
    FROM Purchases p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    WHERE p.ClientID = c.ClientID
) < 100;


-- 20. Staff with 10+ years employed and sold items over $1000
SELECT * FROM Staff s
WHERE DATEDIFF(YEAR, s.HireDate, GETDATE()) > 10
  AND EXISTS (
    SELECT 1
    FROM Purchases p
    JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
    JOIN Items i ON pd.ItemID = i.ItemID
    WHERE p.StaffID = s.StaffID AND i.Price * pd.Quantity > 1000
);
