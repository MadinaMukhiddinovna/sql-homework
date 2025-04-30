               ---------ProductSales Table Tasks---------
----1. Assign a row number to each sale based on the SaleDate

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

---Assigns a unique sequential number to each sale ordered by SaleDate

----2. Rank products based on the total quantity sold (use DENSE_RANK())

SELECT ProductName, SUM(Quantity) AS TotalQuantity,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM ProductSales
GROUP BY ProductName;

---Ranks products by total quantity sold, assigning the same rank to products with equal totals

----3. Identify the top sale for each customer based on the SaleAmount

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS sub
WHERE rn = 1;

---Retrieves the highest sale per customer by ordering sales descendingly and selecting the first

----4. Display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function

SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

---Shows the current and next sale amounts based on SaleDate

----5. Display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function

SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales;

---Shows the current and previous sale amounts based on SaleDate

----6. Rank each sale amount within each product category

SELECT *, RANK() OVER (PARTITION BY ProductName ORDER BY SaleAmount DESC) AS SaleRank
FROM ProductSales;

---Assigns a rank to each sale within its product category based on SaleAmount

----7. Identify sales amounts that are greater than the previous sale's amount

SELECT SaleID, SaleAmount, PreviousSaleAmount
FROM (
    SELECT SaleID, SaleAmount,
           LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
) AS sub
WHERE SaleAmount > PreviousSaleAmount;

---Filters sales where the current amount is greater than the previous sale's amount

----8. Calculate the difference in sale amount from the previous sale for every product

SELECT SaleID, ProductName, SaleAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS AmountDifference
FROM ProductSales;

---Computes the difference between the current and previous sale amounts for each product

----9. Compare the current sale amount with the next sale amount in terms of percentage change

SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
       CASE 
           WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NOT NULL AND SaleAmount <> 0
           THEN (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount
           ELSE NULL
       END AS PercentageChange
FROM ProductSales;

---Calculates the percentage change between the current and next sale amounts

----10. Calculate the ratio of the current sale amount to the previous sale amount within the same product

SELECT SaleID, ProductName, SaleAmount,
       SaleAmount * 1.0 / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS AmountRatio
FROM ProductSales;

---Determines the ratio of current to previous sale amounts for each product

----11. Calculate the difference in sale amount from the very first sale of that product

SELECT SaleID, ProductName, SaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirst
FROM ProductSales;

---Computes the difference between the current sale amount and the first sale amount for each product

----12. Find sales that have been increasing continuously for a product

SELECT SaleID, ProductName, SaleAmount
FROM (
    SELECT *, LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
    FROM ProductSales
) AS sub
WHERE SaleAmount > PrevAmount;

----Identifies sales where the amount increased compared to the previous sale for the same product

----13. Calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales

SELECT SaleID, SaleAmount,
       SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales;

---Computes a running total (closing balance) of sales amounts up to the current sale

----14. Calculate the moving average of sales amounts over the last 3 sales

SELECT SaleID, SaleAmount,
       AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM ProductSales;

---Calculates the average sale amount over the current and previous two sales

----15. Show the difference between each sale amount and the average sale amount

SELECT SaleID, SaleAmount,
       SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAvg
FROM ProductSales;

---Determines how much each sale amount deviates from the overall average

Employees1 Table Tasks
----16. Find Employees Who Have the Same Salary Rank

SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;

---Assigns ranks to employees based on salary, with equal salaries sharing the same rank.

---17. Identify the Top 2 Highest Salaries in Each Department

SELECT *
FROM (
    SELECT *, DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rank
    FROM Employees1
) AS sub
WHERE Rank <= 2;

Retrieves the top two earners in each department

----18. Find the Lowest-Paid Employee in Each Department

SELECT *
FROM (
    SELECT *, RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS Rank
    FROM Employees1
) AS sub
WHERE Rank = 1;

---Identifies the employee(s) with the lowest salary in each department.

---19. Calculate the Running Total of Salaries in Each Department

SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees1;

---Computes a cumulative sum of salaries within each department ordered by hire date

----20. Find the Total Salary of Each Department Without GROUP BY

SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS DepartmentTotal
FROM Employees1;

---Displays each employee's salary along with the total salary of their department

----21. Calculate the Average Salary in Each Department Without GROUP BY

SELECT EmployeeID, Name, Department, Salary,
       AVG(Salary) OVER (PARTITION BY Department) AS DepartmentAvg
FROM Employees1;

---Shows each employee's salary alongside the average salary of their department

----22. Find the Difference Between an Employee’s Salary and Their Department’s Average

SELECT EmployeeID, Name, Department, Salary,
       Salary - AVG(Salary) OVER (PARTITION BY Department) 
	   AS DifferenceFromAvg
FROM Employees1;

---Calculates how much each employee's salary deviates from their department's average

----23. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT EmployeeID, Name, Department, Salary,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees1;

---Computes the average salary over a window of three employees based on hire date

----24. Find the Sum of Salaries for the Last 3 Hired Employees

SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS rn
    FROM Employees1
) AS sub
WHERE rn <= 3;

---Retrieves the three most recently hired employees