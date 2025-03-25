-- List the names of students who have total marks greater than the average total marks of all students.
student name - from students where total marks > avg

-> select avg(marks) scores;
-> select sum(marks) as total from scores group by student_id having total > (select avg(marks) from scores group by std_id);

-> SELECT AVG(tm.total_marks) FROM (SELECT SUM(marks) AS total_marks FROM scores GROUP BY std_id) as tm;



select std_id from scores group by std_id having sum(marks)>5;

select std_id from scores group by std_id having sum(marks)>(SELECT AVG(tm.total_marks) FROM (SELECT
SUM(marks) AS total_marks FROM scores GROUP BY std_id) as tm);



select * from students where id in (1, 3);



select * from students where roll in (select std_id from scores group by std_id having sum(marks)>(SELECT AVG(tm.total_marks) FROM (SELECT
SUM(marks) AS total_marks FROM scores GROUP BY std_id) as tm));

select std_id, avg(marks) from scores group by std_id;








-- Get the details of students whose lowest score in any subject is less than 60.

-- Find the subject with the highest average marks.


-- Find top 2 student names with total marks greater than avg of marks.

select std_id, avg(marks) from scores group by std_id;

select * from students where roll in (select std_id from scores group by std_id having sum(marks)>(SELECT AVG(tm.total_marks) FROM (SELECT SUM(marks) AS total_marks FROM scores GROUP BY std_id) as tm));



--------------------

select name from students order by name asc;


