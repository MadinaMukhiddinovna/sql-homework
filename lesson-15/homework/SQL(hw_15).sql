--1 show  matching and non-matching items side by side ( Cart1 & Cart2)
SELECT	
	COALESCE(c1.Item, c2.Item) AS Item,
	CASE WHEN c1.Item IS NOT NULL THEN 'Yes' ELSE 'No' END AS InCart1,
	CASE WHEN c2.Item IS NOT NULL THEN 'Yes' ELSE 'No' END AS InCart2
	FROM 
	#Cart1 c1 
	FULL OUTER JOIN
	#Cart2 c2 ON c1.Item = c2.Item;

--this query lists all items from both carts, indicating whether each item is present in Cart1, Cart2, or both

--2.Average Number of Days Between Executions(ProcessLog)

WITH ExecutionDiffs AS (
    SELECT
        WorkFlow,
        ExecutionDate,
        DATEDIFF(DAY, LAG(ExecutionDate) OVER (PARTITION BY WorkFlow ORDER BY ExecutionDate), ExecutionDate) AS DaysBetween
    FROM #ProcessLog
)
SELECT WorkFlow,
    AVG(DaysBetween * 1.0) AS AvgDaysBetween
FROM  ExecutionDiffs
WHERE  DaysBetween IS NOT NULL
GROUP BY WorkFlow;

--this query calculates the difference in days between consecutive executions for each workflow and then computes the average of these differences.​

--3.Movies Where Amitabh and Vinod Acted Together as Actors

SELECT MName 
FROM Movie 
WHERE Roles = 'Actor' AND AName in ('Amitabh', 'Vinod')
GROUP BY MName 
HAVING COUNT(DISTINCT AName) = 2;

--this query selects movies where both Amitabh and Vinod have roles as actors

--4.Pivot Phone Numbers into Separate Columns(PhoneDirectory)

SELECT CustomerID, [Cellular], [Work], [Home]
FROM (
	SELECT CustomerID, [Type], PhoneNumber
	FROM #PhonDirectory
	) AS SourceTable
	PIVOT 
	(
	MAX(PhoneNumber)
	FOR [Type] IN ([Cellular], [Work], [Home])
	) AS PivotTable;

--this query transforms rows into columns, displaying each phone type as a separate column for each customer

--5.Find All Numbers Up to n Divisible by 9

DECLARE @n INT = 100;

WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM Numbers WHERE num + 1 <= @n
)
SELECT num FROM Numbers WHERE num % 9 = 0
OPTION (MAXRECURSION 0);

--this query generates numbers from 1 to n and selects those divisible by 9

--6. Return Each Batch with Start and End Lines (BatchStarts, BatchLines)

WITH BatchEnds AS (
    SELECT
        Batch,
        Line,
        ROW_NUMBER() OVER (PARTITION BY Batch ORDER BY Line) AS rn
    FROM  #BatchLines
    WHERE Syntax = 'GO'
),
BatchStartsWithRN AS (
    SELECT  Batch,   BatchStart,
        ROW_NUMBER() OVER (PARTITION BY Batch ORDER BY BatchStart) AS rn
    FROM   #BatchStarts
)
SELECT
    s.Batch,
    s.BatchStart AS StartLine,
    e.Line AS EndLine
FROM BatchStartsWithRN s
JOIN BatchEnds e ON s.Batch = e.Batch AND s.rn = e.rn;

--this query pairs each batch start with its corresponding end line marked by 'GO'

--7.Running Balance of Inventory

SELECT  InventoryDate, QuantityAdjustment,
    SUM(QuantityAdjustment) OVER (ORDER BY InventoryDate) AS RunningBalance
FROM #Inventory;

-- calculates the cumulative sum of quantity adjustments over time to show the runnig balance

--8.Find the Nth Highest Salary (2nd Highest) 

WITH SalaryRanks AS (
    SELECT  Name, Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM NthHighest
)
SELECT  Name, Salary
FROM SalaryRanks
WHERE Rank = 2;

--assigns ranks to salaries and selects the second highest

--9.Current Year's Sales and Previous Two Years
  
  SELECT [Year], SUM(Amount) AS TotalSales
  FROM #Sales 
  WHERE [Year] >= YEAR(GETDATE()) - 2
  GROUP BY [Year];

  --aggregates sales amounts for the current year and the two preceding years

  -----medium tasks----------

  --1.Boxes with Same Demensions

 SELECT length, width, height, COUNT(*) as count
FROM Boxes
GROUP BY length, width, height
HAVING COUNT(*) > 1;

--group by the box dimensions (length, width, height),count how many times each dimension appears,using HAVING COUNT(*) > 1, return only those dimensions that appear more than once (duplicates)

--2.Double number or add 1 

WITH RECURSIVE NumberSeries AS (
  SELECT 1 AS num
  UNION ALL
  SELECT CASE WHEN num * 2 < 100 THEN num * 2 ELSE num + 1 END
  FROM NumberSeries
  WHERE num < 100
)
SELECT * FROM NumberSeries;

--3.Unique statuses up to current row (WorkflowSteps)

SELECT id, status,
       (SELECT COUNT(DISTINCT status) FROM WorkflowSteps
        WHERE step_number <= ws.step_number) AS unique_statuses
FROM WorkflowSteps ws;

--4.Alternate male and female rows

SELECT id, name, gender,
		ROW_NUMBER() OVER (ORDER BY id) AS row_num
		FROM AlternateMaleFemale
		ORDER BY row_num % 2, gender;

--5.Group consecutive status(groupings)

WITH GroupedSteps AS (
  SELECT step_number, status,
         ROW_NUMBER() OVER (ORDER BY step_number) - 
         ROW_NUMBER() OVER (PARTITION BY status ORDER BY step_number) AS group_id
  FROM Steps
)
SELECT MIN(step_number) AS min_step, MAX(step_number) AS max_step, status, COUNT(*) AS count
FROM GroupedSteps
GROUP BY group_id, status;

--6.Binary permutations create all combinations of 0s and 1s for a given length n

WITH RECURSIVE BinaryPermutations AS (
  SELECT '0' AS permutation, 1 AS length
  UNION ALL
  SELECT permutation || '0', length + 1
  FROM BinaryPermutations
  WHERE length < n
  UNION ALL
  SELECT permutation || '1', length + 1
  FROM BinaryPermutations
  WHERE length < n
)
SELECT permutation FROM BinaryPermutations WHERE length = n;

--7.Match spouses, Create a group key to match spouses based on Primary and Spouse IDs

SELECT LEAST(PrimaryID, SpouseID) AS GroupKey, 
       GREATEST(PrimaryID, SpouseID) AS SpouseGroupKey
FROM Spouses;

--8.Get previous quota value 

SELECT id, currentQuota,
       LAG(currentQuota, 1) OVER (ORDER BY id) AS prev_quota
FROM Quotas;

--9.Bowlers next to each other 

SELECT b1.bowler, b2.bowler
FROM BowlingResults b1
JOIN BowlingResults b2
  ON b1.position = b2.position - 1
  OR b1.position = b2.position + 1;

--10.Prime numbers up to 100

SELECT num
FROM Numbers
WHERE num <= 100
AND NOT EXISTS (
  SELECT 1 FROM Numbers n
  WHERE n.num > 1 AND n.num < num AND num % n.num = 0
);

--------difficult 

--1
WITH RECURSIVE BinaryPermutations AS (
  SELECT '0' AS permutation, 1 AS length
  UNION ALL
  SELECT permutation || '0', length + 1
  FROM BinaryPermutations
  WHERE length < n
  UNION ALL
  SELECT permutation || '1', length + 1
  FROM BinaryPermutations
  WHERE length < n
)
SELECT permutation FROM BinaryPermutations WHERE length = n;

--2. Top half players = 1, rest = 2 (playerScores)

WITH RankedPlayers AS (
  SELECT player_id, score, 
         ROW_NUMBER() OVER (ORDER BY score DESC) AS rank, 
         COUNT(*) OVER () AS total_players
  FROM PlayerScores
)
SELECT player_id, 
       CASE WHEN rank <= total_players / 2 THEN 1 ELSE 2 END AS[group]
FROM RankedPlayers;

--3.Break SQL statements into words

SELECT statement_id, word, 
       POSITION(word IN statement) AS start_pos,
       POSITION(word IN statement) + LENGTH(word) AS end_pos
FROM SQLStatements, unnest(string_to_array(statement, ' ')) AS word;

--4.All permutations of n numbers

WITH RECURSIVE Permutations AS (
  SELECT num, ARRAY[num] AS perm
  FROM generate_series(1, n) num
  UNION ALL
  SELECT gs.num, p.perm gs.num
  FROM generate_series(1, n) gs
  JOIN Permutations p ON NOT gs.num = ANY(p.perm)
)
SELECT perm FROM Permutations;

--5.Find all 4-perfect numbers

WITH Divisors AS (
  SELECT num, 
         (SELECT SUM(divisor)
		 FROM generate_series(1, num - 1) divisor
		 WHERE num % divisor = 0) AS divisor_sum
  FROM generate_series(1, 1000) num
)
SELECT num FROM Divisors WHERE divisor_sum = 3 * num;

