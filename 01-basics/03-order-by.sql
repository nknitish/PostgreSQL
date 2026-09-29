-- ============================================
-- ORDER BY: produce a deterministic sort order
-- ============================================

-- 1. CONCEPT
-- ORDER BY sorts the final rows by one or more expressions. Without it, row order
-- is unspecified, even if repeated executions appear to return the same order.

-- 2. WHY IT IS USED
-- Sorting is required for ranked reports, stable pagination, and predictable API output.

-- 3. SYNTAX
-- SELECT columns FROM table
-- ORDER BY expression [ASC | DESC] [NULLS FIRST | NULLS LAST], ...;

-- 4. BASIC EXAMPLES
SELECT name, age
FROM users
ORDER BY age ASC NULLS LAST, name ASC;

SELECT name, created_at
FROM users
ORDER BY created_at DESC;

-- 5. PRACTICAL EXAMPLE
-- Add a unique tie-breaker so users with equal timestamps still have stable ordering.
SELECT id, name, created_at
FROM users
ORDER BY created_at DESC, id DESC;

-- 6. IMPORTANT RULES
-- ASC is the default. PostgreSQL defaults to NULLS LAST for ASC and NULLS FIRST
-- for DESC; state NULL placement when it matters.
-- Multiple keys are considered left-to-right. Later keys break earlier ties.
-- ORDER BY can use a SELECT-list alias or output-column position, but aliases are clearer.
-- Sorting can be expensive for large result sets; an appropriate index may help.

-- 7. COMMON MISTAKES
-- ORDER BY age alone is not stable when multiple rows have the same age.
-- Do not assume the physical insertion order is preserved.

-- 8. INTERVIEW NOTES
-- Ask whether ordering is deterministic before applying LIMIT or paginating.
-- Explain that ORDER BY inside a subquery does not generally order the outer result.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Sort users alphabetically by name.
-- Level 2: Sort active users newest-first, putting equal timestamps in id order.
-- Level 3: Sort products by category, then price descending within each category.
-- Level 4: Design a stable order for a paginated employee directory with nullable salary.