===========homework==============
------------easy
SELECT ASCII('A');      --65 
SELECT LEN('Hello World'); --11
SELECT REVERSE('OpenAI'); --'IAnepO'
SELECT SPACE(5) + 'string';
SELECT LTRIM(' SQL Server'); --'SQL Server'
SELECT UPPER('sql'); --'SQL'
SELECT LEFT('Database', 3); --Dat 
SELECT RIGHT('Technology', 4); --logy
SELECT SUBSTRING('Programming', 3, 4); -- ogra
SELECT CONCAT('SQL', 'Server'); -- SQLServer
SELECT REPLACE('apple pie', 'apple', 'orange'); -- orange pie
SELECT CHARINDEX('learn', 'Learn SQL with LearnSQL'); -- 1
SELECT CHARINDEX('er', 'Server'); -- 2
SELECT VALUE FROM STRING_SPLIT('apple,orange,banana', ',');
SELECT POWER(2, 3); -- 8
SELECT SQRT(16); -- 4
SELECT GETDATE();
SELECT GETUTCDATE();
SELECT DAY('2025-02-03'); -- 3
SELECT DATEADD(DAY, 10, '2025-02-03'); --2025-02-13 00:00:00.000

---------------medium
SELECT CHAR(65); -- 'A'
LTRIM() --'remuves spaces from left',
RTRIM() --from the right
SELECT CHARINDEX('SQL', 'Learn SQL basics'); -- 7
SELECT CONCAT_WS(',', 'SQL', 'Server'); --SQL,Server
SELECT STUFF('test case', 1, 4, 'exam'); -- 'exam case'
SELECT SQUARE(7); -- 49
SELECT LEFT('International', 5); -- 'Inter'
SELECT RIGHT('Database', 2); -- 'se'
SELECT PATINDEX('%n%', 'Learn SQL'); -- 3
SELECT DATEDIFF(DAY, '2025-01-01', '2025-02-03'); -- 33
SELECT MONTH('2025-02-03'); -- 2
SELECT DATEPART(YEAR, '2025-02-03'); -- 2025
SELECT CONVERT(TIME, GETDATE());
SELECT SYSDATETIME();
SELECT DATEADD(DAY, (7 - DATEPART(WEEKDAY, GETDATE())) % 7 + 1, GETDATE());
GETDATE() --return local time,
GETUTCDATE() - UTC
SELECT ABS(-15); -- 15
SELECT CEILING(4.57); -- 5
SELECT CURRENT_TIMESTAMP;
SELECT DATENAME(WEEKDAY, '2025-02-03'); -- 'Monday'

-----------------difficult
SELECT REPLACE(REVERSE('SQL Server'), ' ', ''); --revreSLQS
SELECT STRING_AGG(City, ', ') FROM TableName;
SELECT CHARINDEX('SQL', 'SQL Server') > 0 AND CHARINDEX('Server', 'SQL Server') > 0;
SELECT POWER(5, 3); -- 125
SELECT VALUE FROM STRING_SPLIT('apple;orange;banana', ';');
SELECT TRIM(' SQL '); -- 'SQL'
SELECT DATEDIFF(HOUR, '2025-01-01 00:00:00', '2025-01-02 12:00:00'); -- 36
SELECT DATEDIFF(MONTH, '2023-05-01', '2025-02-03'); -- 21
SELECT LEN('Learn SQL Server') - CHARINDEX('SQL', REVERSE('Learn SQL Server')) + 1; --17
SELECT VALUE FROM STRING_SPLIT('apple,orange,banana', ',');
SELECT DATEDIFF(DAY, '2025-01-01', GETDATE()); --92
SELECT LEFT('Data Science', 4); -- 'Data'
SELECT CEILING(SQRT(225)); -- 15
SELECT CONCAT_WS('|', 'String1', 'String2'); -- 'String1|String2'
SELECT PATINDEX('%[0-9]%', 'abc123xyz'); -- 4
SELECT CHARINDEX('SQL', 'SQL Server SQL', CHARINDEX('SQL', 'SQL Server SQL') + 1); --12
SELECT DATEPART(YEAR, GETDATE()); --2025
SELECT DATEADD(DAY, -100, GETDATE());  --2024-12-24 01:12:27.207
SELECT DATENAME(WEEKDAY, '2025-02-03'); -- 'Monday'
SELECT POWER(5, 2) AS Square;   -- 25