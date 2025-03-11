----first option
SELECT ProductName as Name FROM Products;
SELECT * FROM Customers as Client;

SELECT ProductName FROM Products  
UNION  
SELECT ProductName FROM Products_Discontinued;
