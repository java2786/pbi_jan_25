# View in MySQL
A view is a virtual table that is created from a SELECT query. It does not store data itself but provides a way to present data from one or more tables in a particular format. You can think of it as a saved query that can be used just like a regular table.

### Why Use Views?
- **Simplify Complex Queries**: You can store a complex SELECT query in a view, and then use that view in place of the query, making it easier to read and reuse.
- **Security**: Views can be used to restrict access to specific columns or rows of a table, ensuring users see only what is relevant to them.
- **Consistency**: Views provide a consistent interface for accessing data, which is helpful when different users need the same logical dataset.


## Sample Tables
<pre>
drop database IF EXISTS tutorial;
CREATE DATABASE IF NOT EXISTS tutorial;
use tutorial;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO employees (employee_id, name, department_id, salary) VALUES
(1, 'Arjun', 101, 50000.00),
(2, 'Bheem', 102, 60000.00),
(3, 'Chanakya', 101, 70000.00);
INSERT INTO departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'IT');
</pre>

### Create a View
Suppose we want to see employee names along with their department names, but we want to avoid writing a JOIN every time. We can create a view to simplify this.
<pre>
CREATE VIEW employee_department AS
SELECT employees.name, departments.department_name, employees.salary
FROM employees
JOIN departments ON employees.department_id = departments.department_id;
</pre>

### Use the View
<pre>
SELECT * FROM employee_department;
</pre>

### Filter Data Using the View:
<pre>
SELECT name, salary
FROM employee_department
WHERE department_name = 'HR';
</pre>


## Updating Data Using Views
In MySQL, you can also update data through a view under certain conditions. 

For example, if the view does not use aggregate functions, DISTINCT, or join conditions that complicate data updates, you can use INSERT, UPDATE, or DELETE statements on the view directly.
<pre>
UPDATE employee_department
SET salary = 5000
WHERE name = 'Arjun';
</pre>

## Summary
- Views are virtual tables that represent the result of a SELECT query.
- They are useful for simplifying complex queries, improving security, and maintaining consistency.
- Views can be used for both selecting and modifying data (with some limitations).
