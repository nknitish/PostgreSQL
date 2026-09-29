-- ============================================
-- EXISTS: test whether a related row exists
-- ============================================

-- 1. CONCEPT
-- EXISTS is TRUE when its subquery returns at least one row. The selected values
-- are irrelevant; the subquery may refer to each outer row.

-- 2. WHY IT IS USED
-- It expresses existence/anti-existence without returning or aggregating child rows.

-- 3. BASIC EXAMPLE
SELECT users.id, users.name
FROM users
WHERE EXISTS (
	SELECT 1
	FROM orders
	WHERE orders.user_id = users.id
	  AND orders.status = 'delivered'
);

-- NOT EXISTS finds users without any order, safely handling nullable values in a
-- compared child column (unlike NOT IN's NULL behavior).
SELECT users.id, users.name
FROM users
WHERE NOT EXISTS (
	SELECT 1
	FROM orders
	WHERE orders.user_id = users.id
);

-- 4. IMPORTANT RULES
-- The optimizer may stop searching after it finds a qualifying row.
-- Correlation is by reference to an outer query column, not merely nesting.
-- EXISTS avoids parent duplication when several child rows qualify.

-- 5. COMMON MISTAKES
-- Forgetting the correlation predicate makes EXISTS either always true or depend
-- only on whether the child table has any rows.

-- 6. INTERVIEW NOTES
-- Use EXISTS for semi-join intent and NOT EXISTS for anti-join intent; then verify
-- indexes and actual plan for scale rather than relying on syntax myths.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Find products that have sold at least once.
-- Level 2: Find users with no delivered orders but at least one cancelled order.
-- Level 3: Find departments with employees earning above their department average.
-- Level 4: Find customers who bought every product in a specified category.
