-- ============================================
-- SELECT: retrieve data from a table
-- ============================================
 -- Q1. Select all columns
-- This returns every column from the users table.

SELECT *
FROM users;

-- Q2. Select only specific columns
-- This is cleaner and usually faster than SELECT *.

SELECT id,
       name,
       email
FROM users;

-- Q3. Select one column

SELECT name
FROM users;

-- Q4. Select multiple columns and rename them with aliases

SELECT name AS user_name,
       email AS user_email
FROM users;

-- Example: select a few columns

SELECT name,
       email,
       city
FROM users;

-- Example: create a new value using an expression

SELECT name,
       age + 5 AS future_age
FROM users;

-- Example: combine text values into one output

SELECT name,
       city,
       name || '-' || city AS user_info
FROM users;

-- Example: get unique values only

SELECT DISTINCT city
FROM users;