-- ============================================
-- GROUP BY: aggregate rows into groups
-- ============================================

-- 1. CONCEPT
-- GROUP BY partitions input rows by key values; aggregates produce one output row
-- per group. It reduces detail rather than preserving one result per source row.

-- 2. WHY IT IS USED
-- Reports need metrics by customer, status, department, product, or time period.

-- 3. BASIC EXAMPLES
SELECT city,
	   COUNT(*) AS user_count
FROM users
GROUP BY city
ORDER BY user_count DESC NULLS LAST;

SELECT category,
	   MIN(list_price) AS lowest_price,
	   MAX(list_price) AS highest_price,
	   AVG(list_price) AS average_price
FROM products
GROUP BY category
ORDER BY category;

-- 4. PRACTICAL EXAMPLE
SELECT departments.department_name,
	   COUNT(employees.id) AS employee_count,
	   AVG(employees.salary) AS average_salary
FROM departments
LEFT JOIN employees ON employees.department_id = departments.id
GROUP BY departments.id, departments.department_name
ORDER BY departments.department_name;

-- 5. IMPORTANT RULES
-- Every selected expression must be grouped, aggregated, or functionally dependent
-- on grouped primary-key columns under PostgreSQL's supported rules.
-- NULL grouping keys form one group. WHERE filters rows before grouping.
-- PostgreSQL lets a primary key establish functional dependency for its table's columns.

-- 6. COMMON MISTAKES
-- Selecting a detail column that is neither grouped nor aggregated.
-- Grouping a timestamp by month number without year, merging separate years.
-- Joining two one-to-many tables before aggregation can multiply measures.

-- 7. INTERVIEW NOTES
-- Explain grouping grain explicitly. Be prepared for GROUP BY rules and fan-out errors.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Count users by city, including the NULL city group.
-- Level 2: Calculate product count and average price by category.
-- Level 3: Report order count and delivered revenue by customer and month.
-- Level 4: Include zero-order users and zero-employee departments without inflated totals.
