-- ============================================
-- COUNT: count rows or known values
-- ============================================

-- 1. CONCEPT
-- COUNT(*) counts input rows. COUNT(expression) counts rows where the expression
-- is not NULL. COUNT(DISTINCT expression) counts distinct non-NULL values.

-- 2. WHY IT IS USED
-- Counts measure volume, completeness, uniqueness, and activity.

-- 3. BASIC EXAMPLES
SELECT COUNT(*) AS user_rows,
	   COUNT(age) AS users_with_known_age,
	   COUNT(DISTINCT city) AS distinct_known_cities
FROM users;

-- 4. PRACTICAL EXAMPLE
SELECT user_id,
	   COUNT(*) AS order_count
FROM orders
GROUP BY user_id
ORDER BY order_count DESC, user_id;

-- Count users with zero orders as well: preserve all users with LEFT JOIN.
SELECT users.id,
	   users.name,
	   COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders ON orders.user_id = users.id
GROUP BY users.id, users.name
ORDER BY users.id;

-- 5. IMPORTANT RULES
-- COUNT(*) counts the NULL-extended row from a LEFT JOIN; count a non-null child key
-- such as orders.id to get zero for unmatched parents.
-- COUNT returns bigint in PostgreSQL. Aggregates ignore NULL except COUNT(*).

-- 6. COMMON MISTAKES
-- Counting a nullable column and calling it total rows.
-- Counting after a one-to-many join without understanding row multiplication.

-- 7. INTERVIEW NOTES
-- Classic question: COUNT(*) vs COUNT(column), including a LEFT JOIN with no matches.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Count all products and products currently marked active.
-- Level 2: Count orders per status, including every status present in the data.
-- Level 3: List every user with their order count, including zero.
-- Level 4: Count distinct customers per month without double-counting line items.
