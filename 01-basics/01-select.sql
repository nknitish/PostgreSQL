-- ============================================
-- SELECT: choose values and shape a result
-- ============================================

-- 1. CONCEPT
-- SELECT produces a result set. It can read table columns, calculate expressions,
-- rename output columns, and combine data. A result set is not automatically sorted.

-- 2. WHY IT IS USED
-- Applications and analysts usually need a useful subset or transformation of
-- stored data, not every stored column in its original shape.

-- 3. SYNTAX
-- SELECT expression [AS output_name], ...
-- FROM source;

-- 4. BASIC EXAMPLES
-- * is useful for quick inspection, but avoid it in stable application queries:
-- schema changes can silently change the returned columns and payload size.
SELECT *
FROM users;

SELECT
    id,
    name,
    email
FROM users;

SELECT
    name AS user_name,
    email AS user_email
FROM users;

-- Expressions are computed for each input row; they do not update stored values.
SELECT
    name,
    age + 5 AS age_in_five_years
FROM users;

-- In PostgreSQL, || concatenates text. A NULL input makes the whole expression NULL.
SELECT
    name,
    city,
    name || ' - ' || city AS user_info
FROM users;

-- DISTINCT applies to the complete selected row (here, city), including one NULL.
SELECT DISTINCT city
FROM users;

-- 5. PRACTICAL EXAMPLE
-- Report a readable customer summary without exposing the email address.
SELECT
    id AS user_id,
    name AS customer_name,
    COALESCE(city, 'City not provided') AS city_label,
    is_active
FROM users;

-- 6. IMPORTANT RULES
-- SELECT-list aliases are output names. They are generally usable in ORDER BY,
-- but not WHERE, because WHERE is evaluated before the SELECT list logically.
-- PostgreSQL uses double quotes for identifiers and single quotes for string values.
-- DISTINCT does not mean DISTINCT ON; PostgreSQL's DISTINCT ON has its own ordering rules.

-- 7. COMMON MISTAKES
-- WRONG: WHERE cannot refer to a SELECT-list alias at the same query level.
-- SELECT age + 5 AS future_age FROM users WHERE future_age > 35;
-- CORRECT: repeat the expression or use a subquery/CTE.
SELECT age + 5 AS future_age
FROM users
WHERE age + 5 > 35;

-- 8. INTERVIEW NOTES
-- Explain why SELECT * is risky in production, what DISTINCT deduplicates, and
-- why a query without ORDER BY has no guaranteed row order.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Return each user's name, email, and city.
-- Level 2: Return name and age in ten years, preserving users with unknown ages.
-- Level 3: Return a display label combining user name and city, handling NULL city.
-- Level 4: Build a customer export with renamed columns and only the fields an API needs.