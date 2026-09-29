-- ============================================
-- RECURSIVE CTE: walk a hierarchy or graph
-- ============================================

-- 1. CONCEPT
-- A recursive CTE has an anchor query and a recursive query combined with UNION
-- or UNION ALL. PostgreSQL repeatedly evaluates the recursive term using prior rows.

-- 2. WHY IT IS USED
-- It traverses manager trees, category trees, dependency graphs, and other
-- relationships with unknown depth.

-- 3. PRACTICAL EXAMPLE
-- Start from top-level employees and recursively find their reports.
-- The path check prevents revisiting an employee if bad data contains a cycle.
WITH RECURSIVE employee_tree AS (
    SELECT employees.id,
	    employees.manager_id,
	    employees.first_name,
	    employees.department_id,
	    0 AS depth,
	    ARRAY[employees.id] AS id_path
    FROM employees
    WHERE employees.manager_id IS NULL

    UNION ALL

    SELECT report.id,
	    report.manager_id,
	    report.first_name,
	    report.department_id,
	    employee_tree.depth + 1,
	    employee_tree.id_path || report.id
    FROM employees AS report
    JOIN employee_tree ON report.manager_id = employee_tree.id
    WHERE NOT report.id = ANY(employee_tree.id_path)
)
SELECT id, manager_id, first_name, department_id, depth, id_path
FROM employee_tree
ORDER BY id_path;

-- 4. IMPORTANT RULES
-- The anchor and recursive terms must return compatible column counts and types.
-- UNION removes duplicates and can halt some cycles; UNION ALL is usually faster
-- but needs explicit termination/cycle protection where cycles are possible.
-- A recursive query can run indefinitely or consume large resources if its graph expands.

-- 5. COMMON MISTAKES
-- Omitting a termination condition, or selecting a changing depth/path while expecting
-- UNION to deduplicate repeated nodes.

-- 6. INTERVIEW NOTES
-- Identify anchor, recursive step, termination, depth, cycle behavior, and expected fan-out.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Return all employees beneath one selected manager.
-- Level 2: Include the manager's full name and each employee's depth.
-- Level 3: Traverse a product-category tree and compute each node's descendant count.
-- Level 4: Traverse a directed graph while reporting shortest paths and preventing cycles.
