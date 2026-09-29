-- ============================================
-- IN: test membership in a set
-- ============================================

-- 1. CONCEPT
-- IN is shorthand for a series of equality alternatives. NOT IN is its negation,
-- subject to SQL's three-valued logic.

-- 2. WHY IT IS USED
-- It expresses a finite set of accepted values clearly and can compare against a subquery.

-- 3. BASIC EXAMPLES
SELECT id, name, city
FROM users
WHERE city IN ('Bangalore', 'Delhi', 'Pune');

-- A subquery can produce the candidate set:
SELECT id, name
FROM users
WHERE id IN (
	SELECT user_id
	FROM orders
	WHERE status = 'delivered'
);

-- 4. IMPORTANT RULES
-- IN (a, b) is equivalent to x = a OR x = b.
-- If a NOT IN list/subquery contains NULL, a nonmatching comparison can become
-- UNKNOWN and unexpectedly return no rows. NOT EXISTS is often safer for anti-joins.
-- PostgreSQL also supports array membership with `= ANY(array)`; it is distinct syntax.

-- 5. COMMON MISTAKES
-- Check subquery nullability before using NOT IN. Do not mix unrelated value types.

-- 6. INTERVIEW NOTES
-- Compare IN and EXISTS semantically; modern PostgreSQL may plan either efficiently,
-- but NULL behavior and query meaning should drive the choice.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Find users in three specified cities.
-- Level 2: Find users who have at least one delivered order using IN.
-- Level 3: Find users who have never ordered; compare NOT IN with NOT EXISTS.
-- Level 4: Explain the result when the subquery returns NULL and a nonmatching id.
