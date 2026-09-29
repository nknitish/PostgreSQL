-- ============================================
-- WHERE: filter rows from a table
-- ============================================
 -- 1. CONCEPT
-- WHERE keeps only rows for which its condition is TRUE. FALSE and NULL/UNKNOWN
-- rows are both excluded. It filters input rows before grouping and projection.
 -- 2. WHY IT IS USED
-- Filters reduce a result to the business population a report, API, or update needs.
 -- 3. SYNTAX
-- SELECT columns
-- FROM table
-- WHERE condition;
 -- 4. BASIC EXAMPLES
-- Q1. Show users older than 28.

SELECT *
FROM users
WHERE age > 28;

-- Q2. Show users from Bangalore.

SELECT *
FROM users
WHERE city = 'Bangalore';

-- Q3. Combine conditions. AND binds more tightly than OR; use parentheses for clarity.

SELECT *
FROM users
WHERE city = 'Bangalore'
    AND age > 25;

-- Q4. Match any member of a fixed set.

SELECT *
FROM users
WHERE city IN ('Bangalore',
               'Delhi');

-- Q5. Combine a set match and a range.

SELECT *
FROM users
WHERE city IN ('Bangalore',
               'Delhi')
    AND age > 28;

-- Q6-Q7. BETWEEN includes both endpoints; NOT BETWEEN also excludes NULL ages.

SELECT *
FROM users
WHERE age BETWEEN 27 AND 30;


SELECT *
FROM users
WHERE age NOT BETWEEN 27 AND 30;

-- Q8-Q9. NULL is tested with IS NULL / IS NOT NULL, never = NULL.

SELECT *
FROM users
WHERE age IS NULL;


SELECT *
FROM users
WHERE age IS NOT NULL;

-- Q10-Q11. LIKE is case-sensitive in PostgreSQL. % means any number of characters;
-- _ means exactly one character.

SELECT *
FROM users
WHERE name LIKE 'R%';


SELECT *
FROM users
WHERE name LIKE '%a';

-- ILIKE is PostgreSQL's case-insensitive pattern match.
 
SELECT *
FROM users 
WHERE name ILIKE 'r%';

-- 5. PRACTICAL EXAMPLE
-- Active users in selected cities, but include a deliberate NULL-safe age rule.

SELECT id,
       name,
       city,
       age
FROM users
WHERE is_active IS TRUE
    AND city IN ('Bangalore',
                 'Delhi',
                 'Pune')
    AND (age >= 25
         OR age IS NULL);

-- 6. IMPORTANT RULES
-- Comparisons with NULL yield UNKNOWN; WHERE retains only TRUE.
-- BETWEEN is inclusive: x BETWEEN a AND b means x >= a AND x <= b.
-- Parenthesize mixed AND/OR conditions to make intended logic explicit.
-- A leading wildcard, e.g. '%son', commonly prevents a regular B-tree index scan.
-- Use IS TRUE / IS FALSE when you need to exclude NULL boolean values explicitly.
 -- 7. COMMON MISTAKES
-- WRONG: equality cannot test for NULL.
-- WHERE age = NULL;
-- CORRECT:
-- WHERE age IS NULL;
-- WRONG: this condition unintentionally excludes NULL ages.
-- WHERE age <> 30;
-- Include `OR age IS NULL` if unknown ages belong in the result.
 -- 8. INTERVIEW NOTES
-- Be able to explain three-valued logic, inclusive BETWEEN, AND/OR precedence,
-- and how NULL inside NOT IN can make a predicate UNKNOWN.
 -- 9. PRACTICE TASKS (no solutions)
-- Level 1: Find users with age > 30 and users from Delhi.
-- Level 2: Find users in Bangalore or Delhi whose age is between 25 and 32.
-- Level 3: Find active users whose city is known and whose name contains 'a',
--          case-insensitively.
-- Level 4: Find customers eligible for a campaign: active, in a target city,
--          and either at least 30 or of unknown age; exclude missing cities.