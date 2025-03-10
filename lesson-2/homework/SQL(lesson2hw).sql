--Easy tasks

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Alice', 4500.00);
INSERT INTO Employees (EmpID, Name, Salary) VALUES (2, 'Bob', 5500.00);
INSERT INTO Employees (EmpID, Name, Salary) VALUES (3, 'Charlie', 6000.00);

UPDATE Employees SET Salary = 5000 WHERE EmpID = 1;

select * from Employees where EmpID = 1;

UPDATE Employees SET Salary = 5000 WHERE EmpID = 1;

delete from Epmloyees where Emp_id = 2;

delete from Employees where EmpID = 3;
--delete only empid =3
truncate table Employees; 
drop table Employees; 
--delete all table 

alter table Employees alter column name 
varchar (100);

ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100);

TRUNCATE TABLE Employees;

--Medium-level tasks

 CREATE TABLE Departments (
 DeptID INT PRIMARY KEY,
 DeptName VARCHAR(50) NOT NULL,
 ManagerID INT,
 EmpID INT,
 FOREIGN KEY (EmpID) REFERENCES
 Employees(EmpID)
 );


CREATE TABLE TempDepartmens (
DeptID INT PRIMARY KEY,
DempName VARCHAR(50) NOT NULL,
ManagerID INT,
EmpID INT,
FOREIGN KEY (EmpID) REFERENCES
Employees(EmpID)
);

CREATE TABLE TempDepartments (
    TempID INT PRIMARY KEY,  
    TempName VARCHAR(50),  
    TempManager INT,  
    TempEmpID INT  
);

INSERT INTO TempDepartmens VALUES
(1, 'HR', 101, 1),
(2,'IT', 102, 3),
(3, 'Finance', 103, NULL),
(4, 'Marketing', 104, 2),
(5, 'Operations', 105, NULL);

 INSERT INTO Departments (DeptID, DeptName, ManagerID, EmpID)
SELECT TempID, TempName, TempManager, TempEmpID FROM TempDepartments;

ALTER TABLE Employees ADD Department VARCHAR(50);

UPDATE Employees  
SET Department = 'Management'  
WHERE Salary > 5000;

TRUNCATE TABLE Employees;

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
ALTER TABLE Employees
DROP COLUMN Department;

ALTER TABLE Employees ADD JoimDate DATE;

CREATE TABLE #TempEmployees (
EmpID INT PRIMARY KEY,
Name VARCHAR(50),
Salary DECIMAL(10,2)
);

INSERT INTO #TempEmployees VALUES (1,
'David', 4800.00), (2, 'Emma', 5200.00);
SELECT * FROM #TempEmployees;

DROP TABLE Departments;


-- Hard level tasks
CREATE TABLE Customers (
CustomerID int primary key
identity(1,1),
   Name VARCHAR(50) NOT NULL,
   Age INT CHECK (Age > 18),
   Email VARCHAR(100) UNIQUE
   );

   INSERT INTO Customers (Name, Age, Email)
   VALUES ('John Doe', 25, 'john@example.com');
   ALTER TABLE Employees ADD LastRaiseDate DATE;
UPDATE Employees SET LastRaiseDate = '2021-01-10' WHERE EmpID = 1;
UPDATE Employees SET LastRaiseDate = '2024-02-15' WHERE EmpID = 2;

DELETE FROM Employees  
WHERE DATEDIFF(YEAR, LastRaiseDate, GETDATE()) >= 2;
SELECT * INTO Employees_Backup FROM Employees WHERE 1=0;
SELECT * FROM Employees_Backup;

CREATE TABLE NewEmployees (
    EmpID INT PRIMARY KEY,  
    Name VARCHAR(50),  
    Salary DECIMAL(10,2),  
    Department VARCHAR(50)
);

INSERT INTO NewEmployees VALUES  
(1, 'Alice', 5000, 'HR'),  
(2, 'Bob', 5500, 'IT');

MERGE INTO Employees AS Target  
USING NewEmployees AS Source  
ON Target.EmpID = Source.EmpID  
WHEN MATCHED THEN  
    UPDATE SET Target.Salary = Source.Salary  
WHEN NOT MATCHED THEN  
    INSERT (EmpID, Name, Salary, Department)  
    VALUES (Source.EmpID, Source.Name, Source.Salary, Source.Department);

	USE master;
DROP DATABASE CompanyDB;
CREATE DATABASE CompanyDB;

DROP DATABASE CompanyDB;
CREATE DATABASE CompanyDB;

EXEC sp_rename 'Employees', 'StaffMembers';
SELECT * FROM StaffMembers;

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID) ON DELETE CASCADE ON UPDATE CASCADE
);
DELETE FROM Departments WHERE DeptID = 1;  
UPDATE Departments SET DeptID = 10 WHERE DeptID = 1; 

DBCC CHECKIDENT ('Employees', RESEED, 0);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,  
    ProductName VARCHAR(100) UNIQUE,  -- ”никальное значение  
    Price DECIMAL(10,2) NOT NULL
);