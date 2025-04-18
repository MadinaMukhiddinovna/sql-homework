--Find Employees with Minimum Salary

SELECT * 
FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

--find the lowest salary in the table, and return all employees with that exact salary

--Find Products Above Average Price 

SELECT * 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);

--calculate the average price, and return all products that are more expensive than that

--Find Employees in Sales Department 

SELECT * 
FROM employees 
WHERE department_id = (
	SELECT id
	FROM departments 
	WHERE department_name = 'Sales'
);
--find the ID of the Sales department, then return employees with department ID

--Find Customers with No Orders 

SELECT * 
FROM customers
WHERE customer_id NOT IN (
	SELECT customer_id FROM orders
);
--get customers whose ID id not found in the orders table - means they placed no orders

--Find Products with Max Price in Each Category

SELECT *
FROM products p
WHERE price = ( 
	SELECT MAX(price)
	FROM products
	WHERE category_id = p.category_id 
);
--for each product, compare it with the max price in its own category

--Find Employees in Department with Highest Average Salary

SELECT *
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

--find the department with the highest average salary, then return all its employees

--Find Employees Earning Above Department Average 

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
--compare each employees's salary to the average in their own department

--Find Students with Highes Grade per Course 

SELECT * 
FROM grades g 
WHERE grade = ( 
	SELECT MAX(grade) 
	FROM grades 
	WHERE course_id = g.course_id
);

--return all students whose grade is the highest in their course

--Find Third-Highest Price per Category

WITH RankedProducts AS (
		SELECT *,
				DENSE_RANK() OVER  ( PARTITION BY category_id ORDER BY price DESC) AS rnk
				FROM products
		)
		SELECT * 
		FROM RankedProducts
		WHERE rnk = 3;

--Find Employees Between Company Average and Department Max Salary

SELECT * FROM employees e 
WHERE salary > (SELECT AVG(salary) FROM employees) 
	AND salary < ( 
		SELECT MAX(salary) 
		FROM employees 
		WHERE department_id = e.department_id
);

--find employees whose salary is above the company average and below the top salary in their department