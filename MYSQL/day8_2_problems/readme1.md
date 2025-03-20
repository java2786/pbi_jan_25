# Mysql Basic Query Problems
## How These Problems Help Students
**Basic Queries**: Reinforce understanding of SELECT and WHERE.
**Aggregation Functions**: Teach how to use SUM, AVG, MAX, MIN, and COUNT.
**Nested Queries**: Help students think in layers and solve more complex problems.

## Create database
```sql 
drop database if exists tutorial;
create database if not exists tutorial;
use tutorial;
```

## Tables and Sample Data
**Table**: students
```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    grade VARCHAR(5),
    dob DATE
);

-- Insert sample data with Indian names
INSERT INTO students (name, age, grade, dob)
VALUES
('Amit Sharma', 14, 'A', '2008-05-15'),
('Neha Verma', 15, 'B', '2007-08-22'),
('Ravi Kumar', 13, 'A', '2009-02-17'),
('Priya Singh', 16, 'C', '2006-11-30'),
('Anjali Gupta', 14, 'B', '2008-03-10');
```
**Table**: subjects
```sql
CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100),
    teacher_name VARCHAR(100)
);

-- Insert sample data
INSERT INTO subjects (subject_name, teacher_name)
VALUES
('Mathematics', 'Mr. Joshi'),
('Science', 'Ms. Mehra'),
('English', 'Mrs. Iyer'),
('History', 'Mr. Menon'),
('Art', 'Ms. Nair');
```
**Table**: scores
```sql
CREATE TABLE scores (
    student_id INT,
    subject_id INT,
    marks INT,
    PRIMARY KEY (student_id, subject_id),
    foreign key (student_id) references students(id),
    foreign key (subject_id) references subjects(id)
);

-- Insert sample data
INSERT INTO scores (student_id, subject_id, marks)
VALUES
(1, 1, 85), (1, 2, 78), (1, 3, 92), (1, 4, 88), (1, 5, 95),
(2, 1, 72), (2, 2, 65), (2, 3, 80), (2, 4, 75), (2, 5, 60),
(3, 1, 90), (3, 2, 85), (3, 3, 88), (3, 4, 80), (3, 5, 89),
(4, 1, 60), (4, 2, 55), (4, 3, 70), (4, 4, 65), (4, 5, 75),
(5, 1, 95), (5, 2, 90), (5, 3, 85), (5, 4, 80), (5, 5, 88);
```
### Error 
```sql
INSERT INTO scores (student_id, subject_id, marks) VALUES (6, 10, 99);
INSERT INTO scores (student_id, subject_id, marks) VALUES (5, 1, 99);
```

## Practice Problems
### Level 1: Basic Queries
- Retrieve all student details.  
SELECT * FROM students;

- Find students who are in grade 'A'.

- Get the details of students older than 14 years.

- Find students born after the year 2008.

### Level 2: Aggregation Queries (No Joins)
- Find the total marks scored by each student.

- Find the average marks scored in Science (subject_id = 2).


- Get the highest marks scored in Mathematics (subject_id = 1).
```sql
```