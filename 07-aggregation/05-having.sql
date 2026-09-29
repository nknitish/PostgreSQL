-- ============================================
-- HAVING: filter groups after aggregation
-- ============================================

-- 1. CONCEPT
-- HAVING filters grouped rows after GROUP BY and aggregate calculations.
-- WHERE filters individual input rows before groups are formed.

-- 2. WHY IT IS USED
-- It answers questions such as customers with at least N orders or departments
-- whose average salary exceeds a threshold.

-- 3. BASIC EXAMPLE
SELECT user_id,
	   COUNT(*) AS order_count
FROM orders
GROUP BY user_id
HAVING COUNT(*) >= 2;

-- 4. PRACTICAL EXAMPLE
SELECT employees.department_id,
	   COUNT(*) AS employee_count,
	   AVG(employees.salary) AS average_salary
FROM employees
WHERE employees.hired_at >= DATE '2020-01-01'
GROUP BY employees.department_id
HAVING AVG(employees.salary) > 90000
ORDER BY average_salary DESC;

-- 5. IMPORTANT RULES
-- WHERE can reduce rows before aggregation; use it when the predicate is row-level.
-- HAVING may reference aggregates. A non-aggregate grouping key may also be tested.
-- Use both when the report has row eligibility and group eligibility conditions.

-- 6. COMMON MISTAKES
-- Moving an aggregate condition to WHERE is invalid at that query level.
-- Putting a child-table filter in WHERE after a LEFT JOIN may remove unmatched parents.

-- 7. INTERVIEW NOTES
-- Explain WHERE vs HAVING and how pushing valid filters earlier can reduce work.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find cities with at least two users.
-- Level 2: Find customers with at least two delivered orders.
-- Level 3: Find product categories with revenue above a threshold, excluding cancelled orders.
-- Level 4: Find customers active in at least three distinct months and above a lifetime spend threshold.
