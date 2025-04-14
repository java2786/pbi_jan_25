-- MySQL Joins Practice Guide

-- Step 1: Creating the Database and Tables
DROP DATABASE IF EXISTS tutorial;
CREATE DATABASE IF NOT EXISTS tutorial;
USE tutorial;

-- Table: Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

-- Table: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Table: Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    DepartmentID INT
);

-- Table: EmployeeProjects
CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID)
);

-- Step 2: Inserting Data
-- Employees Table
INSERT INTO Employees VALUES
(1, 'Alice', 'Johnson', 1),
(2, 'Bob', 'Smith', 2),
(3, 'Charlie', 'Brown', NULL),
(4, 'David', 'Wilson', 1),
(5, 'Eve', 'Davis', 3);

-- Departments Table
INSERT INTO Departments VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing');

INSERT INTO Departments VALUES
(4, 'Security');

-- Projects Table
INSERT INTO Projects VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', NULL);

-- EmployeeProjects Table
INSERT INTO EmployeeProjects VALUES
(1, 1, 20),
(2, 2, 15),
(4, 1, 25),
(1, 3, 10),
(5, 3, 30);

-- Step 3: Practice Queries

-- 1. Basic INNER JOIN:
-- Retrieve all employees along with their department names.
select e.FirstName as emp_name, d.DepartmentName as dept_name 
from Employees e 
inner join Departments d 
on d.DepartmentID = e.DepartmentID;

-- 2. LEFT JOIN:
-- List all employees, including those who are not assigned to any department.
select e.FirstName as emp_name, d.DepartmentName as dept_name 
from Employees e 
left join Departments d 
on d.DepartmentID = e.DepartmentID;

-- 3. RIGHT JOIN:
-- List all departments, including those without employees.
select d.DepartmentName as dept_name, e.FirstName as emp_name, e.LastName as emp_ln 
from Employees e
right join Departments d 
on d.DepartmentID = e.DepartmentID;

-- 4. FULL JOIN (using UNION):
-- Combine LEFT JOIN and RIGHT JOIN to show all employees and departments.
select e.FirstName as emp_name, d.DepartmentName as dept_name 
from Employees e 
left join Departments d 
on d.DepartmentID = e.DepartmentID
union
select e.FirstName as emp_name, d.DepartmentName as dept_name 
from Employees e
right join Departments d 
on d.DepartmentID = e.DepartmentID;

-- 5. Complex JOIN:
-- Retrieve all projects along with their assigned employees and departments.

select p.ProjectID, p.ProjectName, e.FirstName, e.LastName, d.DepartmentName
from Projects p 
inner join Departments d on p.DepartmentID = d.DepartmentID
inner join EmployeeProjects ep on ep.ProjectID = p.ProjectID
inner join Employees e on e.EmployeeID = ep.EmployeeID;



-- 6. Filtering Results with JOIN:
-- List employees who have worked more than 20 hours on any project.

select e.EmployeeID, e.FirstName, p.ProjectName, ep.HoursWorked
from Employees e
inner join EmployeeProjects ep on ep.EmployeeID = e.EmployeeID
inner join Projects p on ep.ProjectID = p.ProjectID
where ep.HoursWorked >= 20;

-- 7. Aggregation with JOIN:
-- Calculate the total hours worked by each employee across all projects.
----- Priyanshu
select e.EmployeeID, concat(e.FirstName," ",e.LastName) Emp_Name, sum(ep.HoursWorked)
from Employees e
inner join EmployeeProjects ep on ep.EmployeeID = e.EmployeeID
inner join Projects p on ep.ProjectID = p.ProjectID
group by e.EmployeeID;
----- Priyanshu

----- Ajay
select e.EmployeeID, e.FirstName, SUM(ep.HoursWorked) as Total_Hrs_Worked
from Employees e
inner join EmployeeProjects ep on ep.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.FirstName;
----- Ajay


-- 8. Nested JOIN:
-- Retrieve the names of employees working on projects in the 'Engineering' department.

-- 9. Cross Join:
-- Generate a list of all possible employee-project pairings.

-- 10. Self JOIN:
-- Find pairs of employees working in the same department.

-- 11. Multi-level Aggregation:
-- Find the total hours worked on each project by employees of each department.

-- 12. Conditional JOIN:
-- List employees who are assigned to projects outside their department.

-- 13. Hierarchical JOIN:
-- List all employees, their assigned projects, and the department of each project, including employees without projects.

-- 14. Filtering with Aggregate Functions:
-- Retrieve the names of projects with more than 50 total hours worked.

-- 15. Finding Missing Data:
-- List departments that do not have any associated projects.

-- 16. Multi-table Filtering:
-- Find employees who have not worked on any project in the department they belong to.

-- 17. Subquery with JOIN:
-- Retrieve the names of employees who have worked the most hours on a project.

-- 18. Cumulative Hours per Department:
-- Calculate the total hours worked by employees in each department.


