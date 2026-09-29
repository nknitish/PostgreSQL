-- ============================================
-- SCALAR SUBQUERY: use one value from another query
-- ============================================

-- 1. CONCEPT
-- A scalar subquery returns exactly one column and at most one row. It can be used
-- anywhere a scalar expression is valid. Zero rows produce NULL; multiple rows error.

-- 2. WHY IT IS USED
-- It compares a row with a single aggregate or lookup value without an explicit join.

-- 3. BASIC EXAMPLE
SELECT id, first_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

-- 4. PRACTICAL EXAMPLE
-- Compare each employee to the company-wide average salary.
SELECT employees.id,
	   employees.first_name,
	   employees.salary,
	   (SELECT AVG(salary) FROM employees) AS company_average
FROM employees
ORDER BY employees.salary DESC;

-- 5. IMPORTANT RULES
-- An aggregate without GROUP BY returns one row, even for empty input (value may be NULL).
-- A non-aggregate scalar lookup must be guaranteed unique by a key/constraint.
-- PostgreSQL may optimize an uncorrelated scalar subquery as an init plan.

-- 6. COMMON MISTAKES
-- A subquery returning multiple rows cannot be used with =; use IN, EXISTS, or a join.
-- Scalar subquery NULL results do not match ordinary equality predicates.

-- 7. INTERVIEW NOTES
-- State cardinality guarantees and NULL behavior before choosing scalar syntax.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find products priced above the catalog's average price.
-- Level 2: Find employees earning more than the company's average salary.
-- Level 3: Show each department alongside its headcount as a scalar output column.
-- Level 4: Compare scalar-subquery and join formulations and inspect their plans.
