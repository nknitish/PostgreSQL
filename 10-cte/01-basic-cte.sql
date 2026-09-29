-- ============================================
-- CTE: name a query for one statement
-- ============================================

-- 1. CONCEPT
-- A common table expression (WITH query_name AS (...)) defines a named relation
-- available to the main statement. It can make multi-stage logic easier to read.

-- 2. WHY IT IS USED
-- CTEs give complex queries meaningful stages and avoid repeating derived logic.

-- 3. SYNTAX
-- WITH cte_name (optional_column_names) AS (
--     SELECT ...
-- )
-- SELECT ... FROM cte_name;

-- 4. PRACTICAL EXAMPLE
WITH delivered_order_totals AS (
	SELECT orders.id AS order_id,
		   orders.user_id,
		   SUM(order_items.quantity * order_items.unit_price) AS order_total
	FROM orders
	JOIN order_items ON order_items.order_id = orders.id
	WHERE orders.status = 'delivered'
	GROUP BY orders.id, orders.user_id
)
SELECT users.id,
	   users.name,
	   COALESCE(SUM(delivered_order_totals.order_total), 0) AS lifetime_delivered_spend
FROM users
LEFT JOIN delivered_order_totals
	ON delivered_order_totals.user_id = users.id
GROUP BY users.id, users.name
ORDER BY lifetime_delivered_spend DESC, users.id;

-- 5. IMPORTANT RULES
-- A CTE is scoped to one statement. Multiple CTEs can refer to earlier CTEs.
-- In PostgreSQL 12+, a non-recursive side-effect-free CTE may be inlined; MATERIALIZED
-- can force materialization and NOT MATERIALIZED can request inlining.
-- A CTE is a readability construct, not automatically a performance improvement.

-- 6. COMMON MISTAKES
-- Assuming CTEs are always optimization fences (old PostgreSQL behavior).
-- Returning the wrong grain from a CTE and multiplying rows in a later join.

-- 7. INTERVIEW NOTES
-- Compare CTEs with subqueries on readability, reuse, recursion, and version-specific
-- planning behavior rather than asserting one is always faster.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Use a CTE to list users with known ages over the average.
-- Level 2: Calculate one row per order before summarizing customer spend.
-- Level 3: Rewrite a nested query as named stages without changing its output grain.
-- Level 4: Compare EXPLAIN plans with and without MATERIALIZED on a large source.
