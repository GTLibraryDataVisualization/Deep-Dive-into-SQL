/**
this is the hands-on file for the Georgia Tech Viz Lab SQL Deep Dive Workshop
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



/** Here we talk a little about datatypes - why are they important and how do you use them
/** tinyint(1), smallint(2), mediumint(3), int(4), bigint(8)
/** decimal, numeric
/** char, varchar
/** datetime - YYYY/MM/DD HH:MM:SS **/


/** what do you do if you want to make a new table hypothetically - 
this db seems pretty comprehensive but what if we wanted to make a new table **/

/** here we want to look at some of these fields in DESCRIBE output - what does NULL and KEY mean **/
/** refreshers on PRIMARY KEY concept and how it is important for a relational DB like MySQL **/

/** what if I wanted to delete the table I just made **/



/** i messed up - how do i add/change/remove a column without deleting and recreating the table **/


/** you can also change constraints like primary keys using ALTER TABLE but it won't work on a column that 
cannot become a primary key, unless if you drop the current primary key to add a new primary key
or alter the primary key to become a composite primary key.
-- ALTER TABLE salaries ADD PRIMARY KEY(department_id);
-- SELECT * FROM employees;
-- DESCRIBE employees;
**/
-- Drop the existing primary key

-- Add the new composite primary key constraint




/** now we have a table - which is kind of useless if it doesn't have any data in it
so that is exactly what we will do now **/

/** you can specify column names if you want to leave some columns NULL **/



/** so far we've seen how to change the table structure itself but what if you want to change the data in the table **/


/** any guesses as to why we need the WHERE clause here? **/


/** now we want to get rid of an entire department from the db**/



/** some challenges to see how comfortable you are with querying data **/
select * from employees;

/** get the first 10 employees to be hired **/



/** give the employees a 20% raise because of inflation **/


/** open questions **/

/** exercise for you: give the first 10 employees to be hired a 10000 dollar bonus **/

