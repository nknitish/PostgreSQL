-- ============================================
-- SELF JOIN: relate rows within the same table
-- ============================================

-- 1. CONCEPT
-- A self join reads a table twice under different aliases. It is an ordinary join;
-- the relationship is between two rows of the same relation.

-- 2. WHY IT IS USED
-- Common uses include employee-manager relationships, comparisons, and adjacency lists.

-- 3. BASIC EXAMPLE
-- manager_id references another employees.id; top-level managers have no manager.
SELECT employee.first_name || ' ' || employee.last_name AS employee_name,
	   manager.first_name || ' ' || manager.last_name AS manager_name
FROM employees AS employee
LEFT JOIN employees AS manager ON manager.id = employee.manager_id
ORDER BY employee.id;

-- 4. PRACTICAL EXAMPLE
-- Show pairs of employees in the same department once, not self-pairs or reversals.
SELECT first_employee.department_id,
	   first_employee.first_name AS first_name,
	   second_employee.first_name AS second_name
FROM employees AS first_employee
JOIN employees AS second_employee
	ON second_employee.department_id = first_employee.department_id
   AND second_employee.id > first_employee.id
ORDER BY first_employee.department_id, first_employee.id, second_employee.id;

-- 5. IMPORTANT RULES
-- Give each instance a meaningful alias and qualify columns to avoid ambiguity.
-- Recursive hierarchies of arbitrary depth need a recursive CTE, not repeated self joins.

-- 6. COMMON MISTAKES
-- Joining only on department_id creates each employee paired with every coworker,
-- including themselves and both pair directions.

-- 7. INTERVIEW NOTES
-- Clarify whether output should include root nodes and whether each unordered pair
-- should appear once. For hierarchy depth, discuss cycle prevention.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Display each employee with their manager, including top-level employees.
-- Level 2: Find employees earning more than their manager.
-- Level 3: List coworkers with salary differences above a chosen threshold.
-- Level 4: Find all descendants at arbitrary depth with a recursive CTE and guard cycles.
