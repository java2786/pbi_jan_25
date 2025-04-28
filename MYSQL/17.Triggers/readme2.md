# Triggers

## Key Points About Triggers
- **Events**: Triggers can be fired on specific events:
    - BEFORE INSERT
    - AFTER INSERT
    - BEFORE UPDATE
    - AFTER UPDATE
    - BEFORE DELETE
    - AFTER DELETE

- **Scope**: A trigger is defined for a specific table and event.  
- **Execution**: The trigger executes a set of SQL statements when the event occurs.  
- **OLD and NEW**: MySQL provides these keywords to refer to the data being modified:  
    - **OLD**: Refers to the existing row before an UPDATE or DELETE operation.
    - **NEW**: Refers to the new row being inserted or updated.

## Syntax
```sql
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

## **Example 2**: Prevent Negative Marks
**Task**: Prevent insertion or updating of negative marks in the Students table.

#### Database and Table Creation
```sql
-- Create the database
DROP DATABASE IF EXISTS College;
CREATE DATABASE College;
USE College;

-- Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CollegeID INT,
    SubjectID INT,
    MarksObtained INT
);
```


#### Create a BEFORE INSERT Trigger
```sql
-- Create the trigger to prevent negative marks
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT
ON Students
FOR EACH ROW
BEGIN
    IF NEW.MarksObtained < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot be negative!';
    END IF;
END;
// 
DELIMITER ;

```
#### Test the Trigger
```sql
-- This will succeed
INSERT INTO Students (StudentID, StudentName, CollegeID, SubjectID, MarksObtained)
VALUES (12, 'Ramesh', 2, 3, 75);

-- This will fail
INSERT INTO Students (StudentID, StudentName, CollegeID, SubjectID, MarksObtained)
VALUES (13, 'Mukesh', 2, 3, -10);
```