---1.A view is like a saved SELECT query

SELECT * FROM vwStaff;

 --get all staff data from the view

--2. Create view vwItemPrices

CREATE VIEW vwItemPrices AS
SELECT ItemName, Price FROM Items;

--save item names and prices as a view

--3. Create temp table #TempPurchases

CREATE TABLE #TempPurchases (
    PurchaseID INT,
    ItemName VARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO #TempPurchases VALUES
(1, 'Keyboard', 45.00),
(2, 'Monitor', 150.00);

--temporary table for purchases with sample data

--4. Declare variable @currentRevenue

DECLARE @currentRevenue DECIMAL(10,2);

--store total revenue in a variable

--5. Function fnSquare returns square

CREATE FUNCTION fnSquare (@num INT)
RETURNS INT
AS
BEGIN
    RETURN @num * @num;
END;
 
 --returns square of a number

--6. Procedure spGetClients

CREATE PROCEDURE spGetClients
AS
BEGIN
    SELECT * FROM Clients;
END;

--returns all clients

--7. MERGE Purchases and Clients

MERGE Purchases AS target
USING Clients AS source
ON target.ClientID = source.ClientID
WHEN MATCHED THEN
    UPDATE SET target.Status = 'Updated'
WHEN NOT MATCHED THEN
    INSERT (ClientID, Status) VALUES (source.ClientID, 'New');

--combine data using MERGE

--8. Temp table #StaffInfo

CREATE TABLE #StaffInfo (
    StaffID INT,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

INSERT INTO #StaffInfo VALUES (1, 'Alice', 'Sales'), (2, 'Bob', 'HR');

--stores staff info temporarily

--9. Function fnEvenOdd

CREATE FUNCTION fnEvenOdd (@num INT)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN CASE WHEN @num % 2 = 0 THEN 'Even' ELSE 'Odd' END;
END;

--returns "Even" or "Odd"

--10. Procedure spMonthlyRevenue

CREATE PROCEDURE spMonthlyRevenue @Year INT, @Month INT
AS
BEGIN
    SELECT SUM(Amount) AS TotalRevenue
    FROM Purchases
    WHERE YEAR(PurchaseDate) = @Year AND MONTH(PurchaseDate) = @Month;
END;

--calculates revenue for a month

--11. View vwRecentItemSales

CREATE VIEW vwRecentItemSales AS
SELECT ItemID, SUM(Amount) AS TotalSales
FROM Purchases
WHERE PurchaseDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY ItemID;

--sales per item in the last month

--12. Declare @currentDate and print

DECLARE @currentDate DATE = GETDATE();
PRINT @currentDate;

--stores and shows today’s date

--13. View vwHighQuantityItems

CREATE VIEW vwHighQuantityItems AS
SELECT * FROM Items WHERE Quantity > 100;

--items with quantity > 100

--14. Join temp table #ClientOrders with Purchases

CREATE TABLE #ClientOrders (
    ClientID INT,
    OrderID INT
);

INSERT INTO #ClientOrders VALUES (1, 101), (2, 102);

SELECT co.*, p.*
FROM #ClientOrders co
JOIN Purchases p ON co.OrderID = p.PurchaseID;

--shows client orders by joining tables

--15. Procedure spStaffDetails

CREATE PROCEDURE spStaffDetails @StaffID INT
AS
BEGIN
    SELECT Name, Department FROM Staff WHERE StaffID = @StaffID;
END;

--returns name and department of a staff member

--16. Function fnAddNumbers

CREATE FUNCTION fnAddNumbers (@a INT, @b INT)
RETURNS INT
AS
BEGIN
    RETURN @a + @b;
END;

--adds two numbers

--17. MERGE Items with #NewItemPrices

MERGE Items AS target
USING #NewItemPrices AS source
ON target.ItemID = source.ItemID
WHEN MATCHED THEN UPDATE SET target.Price = source.Price
WHEN NOT MATCHED THEN
    INSERT (ItemID, ItemName, Price) VALUES (source.ItemID, source.ItemName, source.Price);


--updates prices or inserts new items

--18. View vwStaffSalaries

CREATE VIEW vwStaffSalaries AS
SELECT Name, Salary FROM Staff;

--shows staff and their salaries

--19. Procedure spClientPurchases

CREATE PROCEDURE spClientPurchases @ClientID INT
AS
BEGIN
    SELECT * FROM Purchases WHERE ClientID = @ClientID;
END;

--gets all purchases for a client

--20. Function fnStringLength

CREATE FUNCTION fnStringLength (@text VARCHAR(200))
RETURNS INT
AS
BEGIN
    RETURN LEN(@text);
END;

--returns string length.
---------------------------------------------------------------------------------------------


--1. View vwClientOrderHistory

CREATE VIEW vwClientOrderHistory AS
SELECT c.ClientID, p.PurchaseDate, i.ItemName
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
JOIN Items i ON p.ItemID = i.ItemID;

--shows client orders with purchase dates

--2. Create temp table #YearlyItemSales

CREATE TABLE #YearlyItemSales (
    ItemID INT,
    Year INT,
    TotalSales DECIMAL(10,2)
);

INSERT INTO #YearlyItemSales VALUES (1, 2025, 5000), (2, 2025, 3000);

--stores item sales for the year

--3. Procedure spUpdatePurchaseStatus

CREATE PROCEDURE spUpdatePurchaseStatus @PurchaseID INT, @Status VARCHAR(50)
AS
BEGIN
    UPDATE Purchases SET Status = @Status WHERE PurchaseID = @PurchaseID;
END;

--updates the status of a purchase

--4. MERGE Purchases with new data

MERGE Purchases AS target
USING #NewPurchases AS source
ON target.PurchaseID = source.PurchaseID
WHEN MATCHED THEN UPDATE SET target.Status = source.Status
WHEN NOT MATCHED THEN INSERT (PurchaseID, ClientID, Status) VALUES (source.PurchaseID, source.ClientID, source.Status);

--inserts or updates records in Purchases

--5. Declare variable @avgItemSale

DECLARE @avgItemSale DECIMAL(10,2);
SELECT @avgItemSale = AVG(Amount)
FROM Sales WHERE ItemID = 1;

--stores average item sale in a variable

--6. View vwItemOrderDetails

CREATE VIEW vwItemOrderDetails AS
SELECT i.ItemName, p.Quantity, p.PurchaseDate
FROM Purchases p
JOIN Items i ON p.ItemID = i.ItemID;

--shows details of item orders

--7. Function fnCalcDiscount

CREATE FUNCTION fnCalcDiscount (@orderAmount DECIMAL(10,2), @discountPercent DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @orderAmount * (@discountPercent / 100);
END;

--calculates discount based on percentage

--8. Procedure spDeleteOldPurchases

CREATE PROCEDURE spDeleteOldPurchases @Date DATE
AS
BEGIN
    DELETE FROM Purchases WHERE PurchaseDate < @Date;
END;

--deletes purchases older than a specified date

--9. MERGE staff salary data

MERGE Staff AS target
USING #SalaryUpdates AS source
ON target.StaffID = source.StaffID
WHEN MATCHED THEN UPDATE SET target.Salary = source.Salary
WHEN NOT MATCHED THEN
    INSERT (StaffID, Salary) VALUES (source.StaffID, source.Salary);

--updates staff salary or inserts new salary data

--10. View vwStaffRevenue

CREATE VIEW vwStaffRevenue AS
SELECT s.Name, SUM(p.Amount) AS Revenue
FROM Staff s
JOIN Sales p ON s.StaffID = p.StaffID
GROUP BY s.Name;

--shows total revenue per staff member

--11. Function fnWeekdayName

CREATE FUNCTION fnWeekdayName (@date DATE)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN DATENAME(WEEKDAY, @date);
END;

--returns weekday name for a given date

--12. Temp table #TempStaff

CREATE TABLE #TempStaff (
    StaffID INT,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

INSERT INTO #TempStaff SELECT * FROM Staff;

--stores staff data in a temp table

--13. Query total number of client purchases

DECLARE @clientPurchases INT;
SELECT @clientPurchases = COUNT(*) FROM Purchases WHERE ClientID = 1;
PRINT @clientPurchases;

--shows total purchases made by a client

--14. Procedure spClientDetails

CREATE PROCEDURE spClientDetails @ClientID INT
AS
BEGIN
    SELECT * FROM Clients WHERE ClientID = @ClientID;
    SELECT * FROM Purchases WHERE ClientID = @ClientID;
END;

--returns client details and their purchase history

--15. MERGE stock quantities from Delivery

MERGE Items AS target
USING Delivery AS source
ON target.ItemID = source.ItemID
WHEN MATCHED THEN UPDATE SET target.Quantity = target.Quantity + source.Quantity
WHEN NOT MATCHED THEN
    INSERT (ItemID, Quantity) VALUES (source.ItemID, source.Quantity);

--updates stock quantities based on deliveries

--16. Procedure spMultiply

CREATE PROCEDURE spMultiply @num1 INT, @num2 INT
AS
BEGIN
    SELECT @num1 * @num2 AS Product;
END;

--returns the product of two numberss

--17. Function fnCalcTax

CREATE FUNCTION fnCalcTax (@amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @amount * 0.1; -- 10% tax rate
END;

--calculates 10% sales tax on a given amount

--18. View vwTopPerformingStaff

CREATE VIEW vwTopPerformingStaff AS
SELECT s.Name, COUNT(p.PurchaseID) AS OrdersFulfilled
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
GROUP BY s.Name
ORDER BY OrdersFulfilled DESC;

--shows top-performing staff based on orders fulfilled

--19. MERGE synchronize Clients table

MERGE Clients AS target
USING #ClientDataTemp AS source
ON target.ClientID = source.ClientID
WHEN MATCHED THEN UPDATE SET target.Name = source.Name
WHEN NOT MATCHED THEN
    INSERT (ClientID, Name) VALUES (source.ClientID, source.Name);

--synchronizes client data with a temp table

--20. Procedure spTopItems

CREATE PROCEDURE spTopItems
AS
BEGIN
    SELECT TOP 5 ItemName, SUM(Amount) AS TotalSales
    FROM Purchases
    GROUP BY ItemName
    ORDER BY TotalSales DESC;
END;

--returns top 5 best-selling items
-------------------------------------------------------------------------------------------------

--1: spTopSalesStaff

CREATE PROCEDURE spTopSalesStaff @Year INT
AS
BEGIN
    SELECT TOP 1 staff_id, SUM(amount) AS total_revenue
    FROM Sales
    WHERE YEAR(sale_date) = @Year
    GROUP BY staff_id
    ORDER BY total_revenue DESC
END
--finds the staff member with the highest sales in a given year

--2: vwClientOrderStats

CREATE VIEW vwClientOrderStats AS
SELECT client_id, COUNT(*) AS total_orders, SUM(amount) AS total_value
FROM Purchases
GROUP BY client_id

--shows number of orders and total amount per client

--3: MERGE Purchases and Items

MERGE Items AS TARGET
USING (SELECT item_id, price FROM Purchases) AS SOURCE
ON TARGET.item_id = SOURCE.item_id
WHEN MATCHED THEN
    UPDATE SET TARGET.price = SOURCE.price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (item_id, price) VALUES (SOURCE.item_id, SOURCE.price);

--updates or inserts latest item prices from Purchases

--4: fnMonthlyRevenue

CREATE FUNCTION fnMonthlyRevenue(@Year INT, @Month INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2)
    SELECT @Total = SUM(amount)
    FROM Sales
    WHERE YEAR(sale_date) = @Year AND MONTH(sale_date) = @Month
    RETURN ISNULL(@Total, 0)
END

--returns total revenue for a given year and month

--5: spProcessOrderTotals

CREATE PROCEDURE spProcessOrderTotals
    @OrderID INT,
    @Discount DECIMAL(5,2),
    @TaxRate DECIMAL(5,2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2)
    SELECT @Total = SUM(quantity * price) FROM Items WHERE order_id = @OrderID
    SET @Total = @Total - (@Total * @Discount / 100) + (@Total * @TaxRate / 100)
    UPDATE Orders SET status = 'Processed' WHERE order_id = @OrderID
    PRINT 'Total: ' + CAST(@Total AS VARCHAR)
END

--calculates discounted total and updates order status

--6: #StaffSalesData

SELECT staff_id, SUM(amount) AS total_sales
INTO #StaffSalesData
FROM Sales
GROUP BY staff_id

--reates temp table for total sales per staff

--7: MERGE from #SalesTemp to Sales

MERGE Sales AS TARGET
USING #SalesTemp AS SOURCE
ON TARGET.sale_id = SOURCE.sale_id
WHEN MATCHED THEN
    UPDATE SET TARGET.amount = SOURCE.amount
WHEN NOT MATCHED BY TARGET THEN
    INSERT (sale_id, staff_id, amount) VALUES (SOURCE.sale_id, SOURCE.staff_id, SOURCE.amount)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

--synchronizes Sales table with temp data

--8: spOrdersByDateRange

CREATE PROCEDURE spOrdersByDateRange
    @StartDate DATE, @EndDate DATE
AS
BEGIN
    SELECT * FROM Purchases
    WHERE purchase_date BETWEEN @StartDate AND @EndDate
END

--returns purchases in a date range

--9: fnCompoundInterest

CREATE FUNCTION fnCompoundInterest(@Principal DECIMAL(18,2), @Rate DECIMAL(5,2), @Time INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    RETURN @Principal * POWER(1 + @Rate / 100, @Time)
END

--calculates compound interest over time

--10: vwQuotaExceeders

CREATE VIEW vwQuotaExceeders AS
SELECT staff_id, SUM(amount) AS total_sales
FROM Sales
GROUP BY staff_id
HAVING SUM(amount) > 50000

--lists staff with sales over quota

--11: spSyncProductStock

CREATE PROCEDURE spSyncProductStock
AS
BEGIN
    MERGE Products AS T
    USING StockUpdates AS S
    ON T.product_id = S.product_id
    WHEN MATCHED THEN UPDATE SET T.stock_qty = S.stock_qty
    WHEN NOT MATCHED THEN INSERT (product_id, stock_qty) VALUES (S.product_id, S.stock_qty);
END

--updates stock from stock input table

--12: MERGE Staff from external data

MERGE Staff AS TARGET
USING ExternalStaff AS SOURCE
ON TARGET.staff_id = SOURCE.staff_id
WHEN MATCHED THEN UPDATE SET TARGET.name = SOURCE.name
WHEN NOT MATCHED THEN INSERT (staff_id, name) VALUES (SOURCE.staff_id, SOURCE.name);

--syncs staff data from external source

--13: fnDateDiffDays

CREATE FUNCTION fnDateDiffDays(@Date1 DATE, @Date2 DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @Date1, @Date2)
END

--returns days between two dates

--14: spUpdateItemPrices

CREATE PROCEDURE spUpdateItemPrices
AS
BEGIN
    UPDATE Products
    SET price = price * 1.1
    OUTPUT inserted.product_id, inserted.price
END

--increases prices by 10% and shows result

--15: MERGE Clients from temp

MERGE Clients AS TARGET
USING TempClients AS SOURCE
ON TARGET.client_id = SOURCE.client_id
WHEN MATCHED THEN UPDATE SET TARGET.name = SOURCE.name
WHEN NOT MATCHED THEN INSERT (client_id, name) VALUES (SOURCE.client_id, SOURCE.name);

--syncs client info from temp table

--16: spRegionalSalesReport
CREATE PROCEDURE spRegionalSalesReport
AS
BEGIN
    SELECT region, SUM(amount) AS total_sales, AVG(amount) AS avg_sale, COUNT(DISTINCT staff_id) AS staff_count
    FROM Sales
    GROUP BY region
END
--reeturns summary sales report per region

--17: fnProfitMargin

CREATE FUNCTION fnProfitMargin(@Revenue DECIMAL(10,2), @Cost DECIMAL(10,2))
RETURNS DECIMAL(5,2)
AS
BEGIN
    RETURN ((@Revenue - @Cost) / @Revenue) * 100
END

--profit margin percentage

--18: #TempStaffMerge to Staff

MERGE Staff AS TARGET
USING #TempStaffMerge AS SOURCE
ON TARGET.staff_id = SOURCE.staff_id
WHEN MATCHED THEN UPDATE SET TARGET.name = SOURCE.name
WHEN NOT MATCHED THEN INSERT (staff_id, name) VALUES (SOURCE.staff_id, SOURCE.name);

--merges temporary staff data into Staff table

--19: spBackupData

CREATE PROCEDURE spBackupData
AS
BEGIN
    INSERT INTO BackupClients SELECT * FROM Clients
END
--backs up data from Clients to BackupClients

--20: spTopSalesReport
CREATE PROCEDURE spTopSalesReport
AS
BEGIN
    SELECT TOP 10 staff_id, SUM(amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
    FROM Sales
    GROUP BY staff_id
END
--shows top 10 staff with sales rank
