# Stored Procedure

A stored procedure is a set of SQL statements that are saved in the database and can be executed later as a single unit. Think of it as a reusable function that performs a specific task in the database.


### Why Use Stored Procedures?
- **Reusability**: Write once, use multiple times.
- **Encapsulation**: Simplifies complex logic by wrapping it into a procedure.
- **Performance**: Reduces client-server communication by executing multiple SQL statements in one call.
- **Maintainability**: Easier to update business logic in one place.


### Parameters of Stored Procedures
- **IN**: Input parameter.
- **OUT**: Output parameter to return a value.
- **INOUT**: Both input and output parameter.

## Practical
Imagine a company database where employee salaries need to be updated yearly based on a fixed percentage increase. Instead of writing a long SQL query every year, we can use a stored procedure to automate this.

```sql
DROP DATABASE IF EXISTS tutorial;
CREATE DATABASE IF NOT EXISTS tutorial;
USE tutorial;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    exp int
);

INSERT INTO employees (employee_id, name, salary, exp) VALUES
(1, 'Arjun', 50000.00, 2),
(2, 'Bheem', 60000.00, 6),
(3, 'Chanakya', 70000.00, 3);
```

### Stored Procedure
Create a procedure to increase all employee salaries by 5 percent if experience is greater than 5 years otherwise increase salary by 2%.

```sql
DELIMITER //

CREATE PROCEDURE DistributeBonus()
BEGIN
    update employees set salary = salary * 1.05 where exp > 5;
    update employees set salary = salary * 1.02 where exp <= 5;
END // 
DELIMITER ;


call DistributeBonus();
```



### Stored Procedure
Create a procedure to increase all employee salaries by a given percentage.

<pre>
DELIMITER //

CREATE PROCEDURE UpdateSalaries(IN percent_increase DECIMAL(5, 2))
BEGIN
    UPDATE employees
    SET salary = salary + (salary * percent_increase / 100);
END //

DELIMITER ;
</pre>

### Check salaries before calling the Stored Procedure
<pre>
SELECT * FROM employees;
</pre>

### Call the Stored Procedure
Increase salaries by 10%
<pre>
CALL UpdateSalaries(10);
</pre>

### Verify the Results
<pre>
SELECT * FROM employees;
</pre>


## OUT
This procedure calculates the total salary of all employees and stores it in the @total_salary variable.

<pre>
DELIMITER //

CREATE PROCEDURE GetTotalSalary(OUT total_salary DECIMAL(10, 2))
BEGIN
    SELECT SUM(salary) INTO total_salary FROM employees;
END //

DELIMITER ;
</pre>

### Call the procedure and get the result
<pre>
CALL GetTotalSalary(@total_salary);
SELECT @total_salary;
</pre>

## Error Handling
<pre>
DELIMITER //

CREATE PROCEDURE SafeUpdateSalaries(IN percent_increase DECIMAL(5, 2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error occurred. Transaction rolled back.' AS error_message;
    END;

    START TRANSACTION;

    UPDATE employees
    SET salary = salaries + (salary * percent_increase / 100);

    COMMIT;
END //

DELIMITER ;

-- Call the procedure
CALL SafeUpdateSalaries(10);
</pre>

### Call the procedure
<pre>
CALL SafeUpdateSalaries(10);
</pre>

## INOUT
Calculate Updated Salary and Return the Total.
- Takes an employee ID as input.
- Increases the employee's salary by a given percentage.
- Returns the updated salary and the total salary of all employees in the same parameter using INOUT.

<pre>
DELIMITER //

CREATE PROCEDURE UpdateAndGetTotalSalary(
    IN emp_id INT,
    IN percent_increase DECIMAL(5, 2),
    INOUT updated_salary DECIMAL(10, 2)
)
BEGIN
    -- Update the employee's salary
    UPDATE employees
    SET salary = salary + (salary * percent_increase / 100)
    WHERE employee_id = emp_id;

    -- Get the updated salary for the employee
    SELECT salary INTO updated_salary
    FROM employees
    WHERE employee_id = emp_id;

    -- Get the total salary of all employees and return it in the same parameter
    SET updated_salary = updated_salary + (SELECT SUM(salary) FROM employees);
END //

DELIMITER ;
</pre>

### Call the Stored Procedure

<pre>
SET @updated_salary = 0;
CALL UpdateAndGetTotalSalary(1, 10, @updated_salary);
SELECT @updated_salary;
</pre>