-- Query Language categories

1. DQL Data Query Language: SELECT

2. DDL -Data Definition Language: Create, Drop...

3. DML Data Manipulation Lang: INSERT, UPDATE, DELETE...

4. DCL Data Control Language: GRANT, REVOKE

5. TCL -Transaction Control Language: Commit, Rollback

1. Tabular Schema

Definition: A tabular schema is a data structure that organizes information in the form of a table with rows and columns. Each column has a specific data type, and each row represents a record.


2. Difference Between Relational and Non-Relational Databases

Relational Databases (SQL):

Store data in structured tables.

Each table has a predefined schema (columns, data types, relationships).

Use SQL (Structured Query Language) for querying data.

Examples: MySQL, PostgreSQL, SQL Server.


Non-Relational Databases (NoSQL):

Store data in flexible formats such as documents, key-value pairs, graphs, etc.

No fixed schema, allowing different types of data structures.

Suitable for handling large-scale data with high performance.

Examples: MongoDB, Firebase, Cassandra.

3. Difference Between SQL and T-SQL

SQL (Structured Query Language):

A standard language for querying and managing databases.

Used for operations like SELECT, INSERT, UPDATE, DELETE.


T-SQL (Transact-SQL):

An extension of SQL, used in Microsoft SQL Server.

Includes programming features like variables, loops, and conditional statements (IF, WHILE).

Supports stored procedures, triggers, and functions.


Example of an SQL query:

SELECT * FROM Students;

Example of a T-SQL query:

DECLARE @Age INT = 22;  
SELECT * FROM Students WHERE Age = @Age;

4. Basic SQL Commands

1. SELECT – Retrieves data from a table.

SELECT * FROM Users;


2. INSERT – Adds a new record.

INSERT INTO Users (Name, Age) VALUES ('Anna', 22);


3. UPDATE – Modifies existing data.

UPDATE Users SET Age = 23 WHERE Name = 'Anna';


4. DELETE – Removes data from a table.

DELETE FROM Users WHERE Name = 'Anna';
