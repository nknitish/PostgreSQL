-- ============================================
-- WHERE: filter rows from a table
-- ============================================
 -- Q1. Show users older than 28

SELECT *
FROM users
WHERE age > 28;

-- Q2. Show users from Bangalore

SELECT *
FROM users
WHERE city = 'Bangalore';

-- Q3. Show users from Bangalore and older than 25

SELECT *
FROM users
WHERE city = 'Bangalore'
    AND age > 25;

-- Q4. Show users in Bangalore or Delhi

SELECT *
FROM users
WHERE city IN ('Bangalore',
               'Delhi');

-- Q5. Show users in Bangalore/Delhi and older than 28

SELECT *
FROM users
WHERE city IN ('Bangalore',
               'Delhi')
    AND age > 28;

-- Q6. Show users whose age is between 27 and 30

SELECT *
FROM users
WHERE age BETWEEN 27 AND 30;

-- Q7. Show users whose age is outside the 27-30 range

SELECT *
FROM users
WHERE age NOT BETWEEN 27 AND 30;

-- Q8. Show users where the age is NULL

SELECT *
FROM users
WHERE age IS NULL;

-- Q9. Show users where the age is not NULL

SELECT *
FROM users
WHERE age IS NOT NULL;

-- Q10. Show names that start with R

SELECT *
FROM users
WHERE name LIKE 'R%';