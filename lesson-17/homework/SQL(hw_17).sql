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
