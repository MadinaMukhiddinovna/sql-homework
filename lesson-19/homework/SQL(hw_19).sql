           Level 1: Basic Subqueries
--1. Find Employees with Minimum Salary

SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

--we find the smallest salary with MIN(salary) and select employees who earn that salary

--2. Find Products Above Average Price

SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

--first, calculate the average price, then select products with a price higher than that average

Level 2: Nested Subqueries with Conditions
--3. Find Employees in Sales Department

SELECT *
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);

--we find the department ID for "Sales" and then select employees who belong to that department

--4. Find Customers with No Orders

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

--select customers whose ID does not appear in the orders table

Level 3: Aggregation and Grouping in Subqueries
--5. Find Products with Max Price in Each Category

SELECT *
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);

--each product, check if its price is the highest in its own category

--6. Find Employees in Department with Highest Average Salary

SELECT *
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

--department with the highest average salary and select employees from there

Level 4: Correlated Subqueries
--7. Find Employees Earning Above Department Average

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
--for each employee, compare their salary with the average salary in their department

--8. Find Students with Highest Grade per Course

SELECT *
FROM grades g
WHERE grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);

--for each course find the student(s) Who got the highest grade

Level 5: Subqueries with Ranking and Complex Conditions
--9. Find Third-Highest Price per Category

WITH RankedProducts AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank
    FROM products
)
SELECT *
FROM RankedProducts
WHERE rank = 3;

--rank products by price (highest first) inside each category and select the ones ranked 3rd

--10. Find Employees Between Company Average and Department Max Salary

SELECT *
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary)
      FROM employees
      WHERE department_id = e.department_id
  );

--select employees whose salary is higher than the company average but lower than the maximum salary in their department