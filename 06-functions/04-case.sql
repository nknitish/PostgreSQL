-- ============================================
-- CASE: express conditional logic in a query
-- ============================================

-- 1. CONCEPT
-- CASE evaluates conditions in order and returns the result for the first match.
-- It is an expression, so it can appear in SELECT, ORDER BY, aggregates, and more.

-- 2. WHY IT IS USED
-- It derives labels, buckets, and conditional values without changing stored data.

-- 3. SYNTAX
-- CASE
--     WHEN condition THEN result
--     WHEN condition THEN result
--     ELSE fallback
-- END

-- 4. BASIC EXAMPLE
SELECT id,
	   name,
	   CASE
		   WHEN age IS NULL THEN 'unknown'
		   WHEN age < 18 THEN 'under 18'
		   WHEN age < 30 THEN '18-29'
		   ELSE '30+'
	   END AS age_group
FROM users;

-- 5. PRACTICAL EXAMPLE
SELECT id,
	   status,
	   CASE status
		   WHEN 'delivered' THEN 'complete'
		   WHEN 'cancelled' THEN 'closed without delivery'
		   ELSE 'in progress'
	   END AS workflow_group
FROM orders;

-- Conditional aggregation can also be expressed with FILTER (PostgreSQL):
SELECT COUNT(*) FILTER (WHERE status = 'delivered') AS delivered_count,
	   COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_count
FROM orders;

-- 6. IMPORTANT RULES
-- Branch results must resolve to a compatible data type.
-- WHEN clauses are checked top-to-bottom; an early broad condition can shadow later ones.
-- Without ELSE, unmatched rows return NULL.

-- 7. COMMON MISTAKES
-- Do not put overlapping range conditions in the wrong order.
-- CASE is not a procedural loop and does not update the source row.

-- 8. INTERVIEW NOTES
-- Expect CASE-based bucketing, conditional counts, and questions about NULL/ELSE behavior.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Label users as active or inactive with readable output.
-- Level 2: Bucket products into low, medium, and high price ranges.
-- Level 3: Count each order status in one result row.
-- Level 4: Calculate customer lifetime value tiers while handling customers with no orders.
