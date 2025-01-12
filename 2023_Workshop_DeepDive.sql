/**
this is the solution file for the Georgia Tech Viz Lab SQL Deep Dive Workshop
initially written in Spring 2022 and updated in Spring 2023

please make sure that you have run create_db.sql to load the schema and data
This is created as a follow up to the SQL Introductory Workshop.

the db is taken from https://www.sqltutorial.org/sql-sample-database/
**/

/** the focus for today is going to be creating and manipulating tables themselves. */

/**first thing you want to do is make sure you're using the right db **/

USE HR;

/** if you're using a db for the first time and there's no GUI conveniently placed for you to understand the db
what do you do?? **/

SHOW TABLES;
DESCRIBE countries;

/** recapping getting details from tables**/
/** you can use the logical operators **/
SELECT * FROM employees;
SELECT * FROM employees WHERE employee_id = 105;
SELECT * FROM employees WHERE employee_id = 105 OR employee_id = 110;
SELECT * FROM employees WHERE employee_id BETWEEN 105 AND 110;


/** Here we talk a little about datatypes - why are they important and how do you use them
/** tinyint(1), smallint(2), mediumint(3), int(4), bigint(8)
/** decimal, numeric
/** char, varchar
/** datetime - YYYY/MM/DD HH:MM:SS **/


/** what do you do if you want to make a new table hypothetically - 
this db seems pretty comprehensive but what if we wanted to make a new table **/
CREATE TABLE IF NOT EXISTS salaries(department_id char(3), department_name varchar(50), avg_salary decimal(9, 2), number_of_employees int);
DESCRIBE salaries;
/** here we want to look at some of these fields in DESCRIBE output - what does NULL and KEY mean **/
/** refreshers on PRIMARY KEY concept and how it is important for a relational DB like MySQL **/

/** what if I wanted to delete the table I just made **/
DROP TABLE salaries;

CREATE TABLE salaries(department_id char(3) PRIMARY KEY, department_name varchar(50), avg_salary decimal(9, 2), number_of_employees int);
/** i messed up - how do i add/change/remove a column without deleting and recreating the table **/
ALTER TABLE salaries MODIFY department_id int;
ALTER TABLE salaries ADD department_code char(3);
ALTER TABLE salaries DROP department_code;

/** you can also change constraints like primary keys using ALTER TABLE but it won't work on a column that 
cannot become a primary key, unless if you drop the current primary key to add a new primary key
or alter the primary key to become a composite primary key.
-- ALTER TABLE salaries ADD PRIMARY KEY(department_id);
-- SELECT * FROM employees;
-- DESCRIBE employees;
**/
-- Drop the existing primary key
ALTER TABLE salaries DROP PRIMARY KEY;
-- Add the new composite primary key constraint
ALTER TABLE salaries ADD PRIMARY KEY (department_id, department_name);

ALTER TABLE salaries DROP PRIMARY KEY;
ALTER TABLE salaries ADD PRIMARY KEY (department_id);

/** now we have a table - which is kind of useless if it doesn't have any data in it
so that is exactly what we will do now **/
INSERT INTO salaries VALUES(501, 'Sales', 75000.00, 24);
select * from salaries;
/** you can specify column names if you want to leave some columns NULL **/
INSERT INTO salaries(department_id, department_name, number_of_employees) VALUES(502, 'Tech', 105);


/** so far we've seen how to change the table structure itself but what if you want to change the data in the table **/
-- SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = 0;
UPDATE salaries SET avg_salary = 50000.00 WHERE department_name = 'Tech';
UPDATE salaries SET avg_salary = 40000.00 WHERE department_id = 502;
/** any guesses as to why we need the WHERE clause here? **/

/** now we want to get rid of an entire department from the db**/
DELETE FROM salaries WHERE department_name='Tech';
SELECT * FROM salaries;


/** some challenges to see how comfortable you are with querying data **/
select * from employees;

/** get the first 10 employees to be hired **/
SELECT * FROM employees ORDER BY hire_date LIMIT 10;
-- SELECT * FROM employees ORDER BY hire_date DESC LIMIT 10;

/** give the employees a 20% raise because of inflation **/
UPDATE employees SET salary = salary + (0.2 * salary);

/** open questions **/

/** exercise for you: give the first 10 employees to be hired a 10000 dollar bonus **/
-- May result in Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
-- UPDATE employees SET salary = salary + 10000
-- WHERE employee_id IN (
--   SELECT employee_id
--   FROM employees
--   ORDER BY hire_date ASC
--   LIMIT 10
-- );

UPDATE employees e
JOIN (
  SELECT employee_id
  FROM employees
  ORDER BY hire_date ASC
  LIMIT 10
) e2 ON e.employee_id = e2.employee_id
SET e.salary = e.salary + 10000;
