--Easy level tasks

BULK INSERT Products  
FROM 'C:\data\products.csv'  
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    TABLOCK  
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Price)  
VALUES  
    (1, 'Laptop', 999.99),  
    (2, 'Mouse', 19.99),  
    (3, 'Keyboard', 49.99);

  CREATE TABLE Example (
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT NULL
);

INSERT INTO Example (ID, Name, Age)
VALUES (1, 'Alice', NULL);

ALTER TABLE Products  
ADD CONSTRAINT UQ_ProductName 
UNIQUE (ProductName);

SELECT * FROM Products WHERE Price > 50;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(50)
);

INSERT INTO Users (UserName) VALUES ('John');

--Medium level tasks

   CREATE TABLE Products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(50),
   Price DECIMAL(10,2)
   );

   BULK INSERT Products
FROM 'C:/temp/Products.txt'
WITH (
     FORMAT = 'CSV',
   FIRSTROW = 1,
   FIELDTERMINATOR = '|',
   ROWTERMINATOR = '/n',
   TABLOCK
   );

   CREATE TABLE Sales (
   SalesID INT PRIMARY KEY,
   ProductName VARCHAR(50),
   Quantity int,
   Price DECIMAL(10,2),
   SalesDate DATE
   );


   SELECT * FROM Products
   FOR XML AUTO, ELEMENTS;

   CREATE TABLE Categories (
       CategoryID int PRIMARY KEY,
     CategoryName VARCHAR(50) UNIQUE
     );

     ALTER TABLE Products
     ADD CategoryID int;

    ALTER TABLE Products
    ADD CONSTRAINT FK_Products_Categories
    FOREIGN KEY (CategoryID)
    REFERENCES Categories (CategoryID);

  CREATE TABLE Employees (
  EmployeeID int primary key,
  Email VARCHAR(100) UNIQUE
  );

  ALTER TABLE Products
  ADD CONSTRAINT CHK_Price CHECK (Price >
  0);

  SELECT * FROM Products
  for JSON AUTO;

  ALTER TABLE Products
  ADD Stock int not null default 0;

  select ProductID, ProductName,
  ISNULL(Stock, 0) AS Stock
  from Products;

  ALTER TABLE Products
  ADD CONSTRAINT
  FK_Products_Categories_Cascade FOREIGN
  KEY (CategoryID)
  REFERENCES Categories (CategoryID)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--hard level tasks

CREATE TABLE Customers (
CustumerID int primary key,
FullName VARCHAR(100),
Age int check (Age >= 18)
);

INSERT INTO Customers (CustomerID, FullName, Age)  
VALUES (1, 'John Doe', 25), (2, 'Jane Smith', 17);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

INSERT INTO Orders 
(OrderID, CustomerID, OrderDate, TotalAmount)
SELECT * FROM OPENROWSET
(BULK 'C:\temp\orders.json', SINGLE_CLOB) AS jsonData;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(100,10) PRIMARY KEY,
    FullName VARCHAR(100)
);

INSERT INTO Employees (FullName) 
VALUES ('Alice Johnson'), ('Bob Brown');
SELECT * FROM Employees;

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
SELECT COALESCE(NULL, NULL, 'Hello', 'World');
SELECT ISNULL(NULL, 'Default Value');


MERGE INTO Products AS target  
USING (  
    SELECT * FROM OPENROWSET(BULK
  'C:\temp\products.txt', SINGLE_CLOB) AS source  
) AS sourceData  
ON target.ProductID = sourceData.ProductID  
WHEN MATCHED THEN  
    UPDATE SET target.Price = sourceData.Price  
WHEN NOT MATCHED THEN  
    INSERT (ProductID, ProductName, Price)  
    VALUES (sourceData.ProductID,
  sourceData.ProductName, sourceData.Price);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);

ALTER TABLE Orders  
ADD CONSTRAINT FK_Orders_Customers 
FOREIGN KEY (CustomerID)  
REFERENCES Customers (CustomerID)  
ON DELETE CASCADE  
ON UPDATE CASCADE;
