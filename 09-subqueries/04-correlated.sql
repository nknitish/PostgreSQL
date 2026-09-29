-- ============================================
-- CORRELATED SUBQUERY: use values from an outer row
-- ============================================

-- 1. CONCEPT
-- A correlated subquery references columns from the outer query. Conceptually it
-- depends on each outer row, though the optimizer may transform its execution.

-- 2. WHY IT IS USED
-- It expresses per-row comparisons and existence checks over related data.

-- 3. PRACTICAL EXAMPLE
-- Employees earning more than the average of their own department:
SELECT employee.id,
	   employee.first_name,
	   employee.department_id,
	   employee.salary
FROM employees AS employee
WHERE employee.salary > (
	SELECT AVG(colleague.salary)
	FROM employees AS colleague
	WHERE colleague.department_id = employee.department_id
);

-- 4. TOP-N PER GROUP EXAMPLE
-- Correlated count of peers with a higher price; ties need an explicit tie-breaker.
SELECT product.id,
	   product.product_name,
	   product.category,
	   product.list_price
FROM products AS product
WHERE (
	SELECT COUNT(*)
	FROM products AS more_expensive
	WHERE more_expensive.category = product.category
	  AND (more_expensive.list_price, more_expensive.id)
		  > (product.list_price, product.id)
) < 2;

-- 5. IMPORTANT RULES
-- Correlation must be explicit and correctly scoped. Compare with a window function
-- or grouped join when that better expresses the task or scales more clearly.
-- Row-value comparisons are lexicographic in PostgreSQL; NULLs need deliberate handling.

-- 6. COMMON MISTAKES
-- Assuming every correlated subquery literally runs once per row; actual plans vary.
-- Forgetting a grouping key in the correlated predicate.

-- 7. INTERVIEW NOTES
-- Explain logical dependency separately from physical execution and use EXPLAIN ANALYZE
-- only with awareness that it executes the query.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find products above their category average.
-- Level 2: Find each employee's manager-relative salary comparison.
-- Level 3: Return the two most recent orders for every customer.
-- Level 4: Compare correlated top-N with ROW_NUMBER and discuss tie semantics.
