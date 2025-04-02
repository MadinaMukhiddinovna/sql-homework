--1-----Extract a Substring

SELECT SUBSTRING('DATABASE', 1, 4);  ---DATA

--2-----Find Position of a Word

SELECT CHARINDEX('SQL', 'I love SQL Server');  --8
------------------ 'SQL'.

--3-----Replace a Word

SELECT REPLACE('Hello World', 'World', 'SQL'); --Hello SQL

--4-----Find String Length

SELECT LEN('Microsoft SQL Server');  --20

--5-----Extract Last 3 Characters

SELECT RIGHT('Database', 3);  --ase

--6-----Count a Character

SELECT LEN('apple') - LEN(REPLACE('apple', 'a', '')) AS CountA1,
       LEN('banana') - LEN(REPLACE('banana', 'a', '')) AS CountA2,
       LEN('grape') - LEN(REPLACE('grape', 'a', '')) AS CountA3;

--7-----Remove Part of a String

SELECT STUFF('abcdefg', 1, 5, ''); --fg

--8-----Extract a Word

SELECT PARSENAME(REPLACE('SQL is powerful', ' ', '.'), 2);  --is

--9-----Round a Number

SELECT ROUND(15.6789, 2);  --15.6800

--10-----Absolute Value

SELECT ABS(-345.67);  --'345.67'

--11-----Find Middle Characters

SELECT SUBSTRING('ABCDEFGHI', 4, 3);  --DEF

--12-----Replace Part of String

SELECT STUFF('Microsoft', 1, 3, 'XXX');  --XXXrosoft

--13-----Find First Space

SELECT CHARINDEX(' ', 'SQL Server 2025');   --4

--14-----Concatenate Names

SELECT CONCAT(FirstName, ', ', LastName) FROM Employees;

--15-----Find Nth Word

SELECT PARSENAME(REPLACE('The database is very efficient', ' ', '.'), 3);   --NULL

--16-----Extract Only Numbers

SELECT RIGHT('INV1234', 4), RIGHT('ORD5678', 4);  --'1234'	'5678'

--17-----Round to Nearest Integer

SELECT ROUND(CAST(99.5 AS FLOAT), 0);  --100

--18-----Find Day Difference

SELECT DATEDIFF(DAY, '2025-01-01', '2025-03-15');  --73

--19-----Find Month Name

SELECT DATENAME(MONTH, '2025-06-10');  --June

--20-----Calculate Week Number

SELECT DATEPART(WEEK, '2025-04-22');  --17

--21-----Extract After '@'

SELECT RIGHT('user1@gmail.com', CHARINDEX('@', REVERSE('user1@gmail.com')) - 1);  --gmail.com

--22-----Find Last Occurrence

SELECT LEN('experience') - CHARINDEX('e', REVERSE('experience')) + 1;    --10

--23-----Generate Random Number

SELECT FLOOR(RAND() * (500 - 100 + 1) + 100);  --'403'

--24-----Format with Commas

SELECT FORMAT(9876543, 'N0');    --'9,876,543'

--25-----Extract First Name

SELECT LEFT(FullName, CHARINDEX(' ', FullName) - 1) FROM Customers;

--26-----Replace Spaces with Dashes

SELECT REPLACE('SQL Server is great', ' ', '-');    --SQL-Server-is-great

--27-----Pad with Zeros

SELECT FORMAT(42, '00000');    --'00042'

--28-----Find Longest Word Length

SELECT MAX(LEN(value)) FROM STRING_SPLIT('SQL is fast and efficient', ' ');    --'9'

--29-----Remove First Word

SELECT STUFF('Error: Connection failed', 1, CHARINDEX(' ', 'Error: Connection failed'), '');   --Connection failed

--30-----Find Time Difference

SELECT DATEDIFF(MINUTE, '08:15:00', '09:45:00');   --'90'