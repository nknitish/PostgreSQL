-- ============================================
-- DISTINCT: remove duplicate result rows
-- ============================================

-- 1. CONCEPT
-- DISTINCT removes duplicate rows from the SELECT result. It compares the complete
-- selected tuple, not one hidden key.

-- 2. WHY IT IS USED
-- It is useful for enumerating categories or deduplicating a projected result.
-- If the question asks for a count, COUNT(DISTINCT expression) may be clearer.

-- 3. SYNTAX
-- SELECT DISTINCT expression, ... FROM table;

-- 4. BASIC EXAMPLES
SELECT DISTINCT city
FROM users
ORDER BY city NULLS LAST;

-- These rows are distinct whenever either selected value differs.
SELECT DISTINCT city, is_active
FROM users
ORDER BY city NULLS LAST, is_active;

-- 5. PRACTICAL EXAMPLE
SELECT DISTINCT category
FROM products
WHERE is_active IS TRUE
ORDER BY category;

-- PostgreSQL extension: DISTINCT ON keeps the first row in each key group.
-- ORDER BY must put the desired winner first; without it, the chosen row is unpredictable.
SELECT DISTINCT ON (user_id)
       user_id,
       id AS latest_order_id,
       ordered_at,
       status
FROM orders
ORDER BY user_id, ordered_at DESC, id DESC;

-- 6. IMPORTANT RULES
-- Duplicate rows containing NULL in the same positions collapse into one result row.
-- DISTINCT may require sorting or hashing and can be costly on large results.
-- DISTINCT ON is PostgreSQL-specific; standard SQL has DISTINCT but not DISTINCT ON.

-- 7. COMMON MISTAKES
-- SELECT DISTINCT city, name does not return one row per city; name participates too.
-- DISTINCT is not a substitute for understanding why a JOIN multiplied rows.

-- 8. INTERVIEW NOTES
-- Explain DISTINCT versus GROUP BY for deduplication and identify which columns
-- determine uniqueness. For latest-per-group, discuss DISTINCT ON versus window ranking.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: List distinct user cities, with unknown city shown once.
-- Level 2: Count distinct cities among active users.
-- Level 3: Return the most recent order for every user who has placed an order.
-- Level 4: Return each customer's latest non-cancelled order, resolving timestamp ties.