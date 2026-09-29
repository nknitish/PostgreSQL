-- ============================================
-- RIGHT JOIN: preserve every row from the right side
-- ============================================

-- 1. CONCEPT
-- RIGHT JOIN preserves all rows from its right input; unmatched left columns become NULL.

-- 2. WHY IT IS USED
-- It can express the same unmatched-row reporting as LEFT JOIN with table order reversed.

-- 3. BASIC EXAMPLE
SELECT employees.id AS employee_id,
	   departments.department_name
FROM employees
RIGHT JOIN departments ON departments.id = employees.department_id
ORDER BY departments.id, employees.id;

-- Equivalent and often easier to read with the preserved table first:
SELECT employees.id AS employee_id,
	   departments.department_name
FROM departments
LEFT JOIN employees ON employees.department_id = departments.id
ORDER BY departments.id, employees.id;

-- 4. IMPORTANT RULES
-- RIGHT JOIN has the same NULL-extension behavior as LEFT JOIN, with sides reversed.
-- PostgreSQL supports RIGHT JOIN; rewriting it as LEFT JOIN can improve readability.

-- 5. COMMON MISTAKES
-- Do not mistake the textual right side for the preserved side after nesting joins.
-- A WHERE predicate on nullable left columns can remove preserved right rows.

-- 6. INTERVIEW NOTES
-- Most teams prefer LEFT JOIN consistently because the preserved relation is visible first.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Show every department and any matching employee.
-- Level 2: Rewrite the same result with LEFT JOIN and explain which side is preserved.
-- Level 3: Add a condition for employees hired after 2021 without losing empty departments.
