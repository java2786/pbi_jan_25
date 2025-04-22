# Index
- An index is a data structure that helps speed up data retrieval operations on a database table, similar to an index in a book. Instead of scanning through every page to find a specific topic, an index allows you to go directly to the page where the information is located.
- In a database, indexes are used to locate data quickly without having to search every row in a table whenever a query is run. They work like a lookup table that points to where the data is stored.

### Why Use Indexes?
- **Speed up SELECT Queries**: They help in reducing the time it takes to find specific rows in a table.
- **Enforce Uniqueness**: An index can be used to enforce unique values in a column (like primary keys).
- **Sorting and Filtering**: Indexes speed up operations like ORDER BY, GROUP BY, and filtering in WHERE clauses.

***Note***: While indexes make reads faster, they can slow down write operations (INSERT, UPDATE, DELETE) because the index also needs to be updated.

## Types of Indexes in MySQL
### **Primary Index**:
- Automatically created on a primary key column. Ensures uniqueness and allows for quick access.
- Example: When you define a column as a PRIMARY KEY, MySQL automatically creates an index.

### **Normal (Non-Unique) Index**:
Speeds up data retrieval, but values can be duplicated.
<pre>
CREATE INDEX idx_name ON employees(name);
</pre>

### **Unique Index**:
Ensures all values in a column are unique.
<pre>
CREATE UNIQUE INDEX idx_email ON users(email);
</pre>

### **Composite Index**:
An index on multiple columns, useful when queries involve multiple columns in the WHERE clause.
<pre>
CREATE INDEX idx_name_dept ON employees(name, department_id);
</pre>

### **Full-Text Index**:
Used for text searches (e.g., searching large text fields or documents).
<pre>
CREATE FULLTEXT INDEX idx_description ON articles(description);
</pre>


# Examples:
Suppose we want to frequently query employees by their name. Creating an index on the name column can help speed up these queries.
<pre>
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

CREATE INDEX idx_name ON employees(name);
</pre>

This creates an index named idx_name on the name column. Now, if you run a query that searches by name, the database can use the index to find matching rows more efficiently.

### Dropping an Index

<pre>
DROP INDEX idx_name ON employees;
</pre>


### Composite Index
If you often filter results by both name and department_id, a composite index can be beneficial.
<pre>
CREATE INDEX idx_name_department ON employees(name, department_id);
</pre>

This index can be used when queries involve both name and department_id in a WHERE clause. A composite index can provide faster results than having separate indexes on name and department_id.


# Usage
### Using EXPLAIN to See Query Performance
<pre>
EXPLAIN SELECT * FROM employees WHERE name = 'Arujn';
</pre>

EXPLAIN provides details on how MySQL executes a query, including whether it uses an index. This helps you understand if the index you created is being utilized effectively.


## Practical Example: Without and With Index

<pre>
SELECT * FROM employees WHERE name = 'Bheem';
</pre>

MySQL will perform a full table scan, meaning it has to check every row until it finds all rows that match name = 'Bheem'. This can be very slow for large datasets.


<pre>
CREATE INDEX idx_name ON employees(name);
SELECT * FROM employees WHERE name = 'Bheem';
</pre>

MySQL will use the index to locate the rows quickly, instead of scanning the entire table.


## When to Use Indexes (Best Practices)
- **Frequent Lookups**: Add indexes to columns that are frequently used in SELECT queries, especially in WHERE clauses.
- **Foreign Keys**: It is a good idea to index columns that are used as foreign keys to speed up joins.
- **Avoid Over-Indexing**: Too many indexes can slow down INSERT, UPDATE, and DELETE operations.
- **Column Selectivity**: Indexes are most useful on columns with high selectivity, meaning the values are mostly unique (e.g., email addresses). Indexing columns with only a few distinct values (e.g., "male" or "female") may not be effective.



## More
```sql
drop DATABASE IF EXISTS tutorial;
create database tutorial;
use tutorial;

CREATE TABLE departments (
    department_id INT PRIMARY KEY auto_increment,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT auto_increment,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    primary KEY (employee_id)
);


insert into departments(department_name) values
('hr'),
('it'),
('marketing'),
('finance');


INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date) 
VALUES
(1, 'Ramesh', 'Kumar', 1, 60000, '2020-01-15'),
(2, 'Mahesh', 'Sharma', 2, 75000, '2019-03-12'),
(3, 'Suresh', 'Dube', 1, 70000, '2021-06-23'),
(4, 'Gukesh', 'Tiwari', 3, 55000, '2022-11-01'),
(5, 'Kamkesh', 'Tiwari', 3, 75000, '2022-11-01');



show index from employees;
CREATE INDEX idx_name ON employees(first_name);
show index from employees;

INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, hire_date) 
VALUES
(6, 'Ramesh', 'Kumar', 1, 31000, '2020-02-17');


EXPLAIN SELECT * FROM employees WHERE first_name = 'Arujn';

EXPLAIN SELECT * FROM employees WHERE last_name = 'Arujn';
```