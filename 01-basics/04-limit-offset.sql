-- ============================================
-- LIMIT / OFFSET: cap and skip rows
-- ============================================

-- 1. CONCEPT
-- LIMIT caps the number of returned rows. OFFSET skips rows before returning them.

-- 2. WHY IT IS USED
-- These clauses support previews and simple page-number pagination.

-- 3. SYNTAX
-- SELECT ... ORDER BY ... LIMIT row_count OFFSET rows_to_skip;

-- 4. BASIC EXAMPLES
SELECT id, name
FROM users
ORDER BY id
LIMIT 5;

SELECT id, name
FROM users
ORDER BY id
LIMIT 5 OFFSET 5;

-- PostgreSQL also supports the SQL-standard FETCH FIRST form.
SELECT id, name
FROM users
ORDER BY id
FETCH FIRST 5 ROWS ONLY;

-- 5. PRACTICAL EXAMPLE
-- Most recent orders. A unique tie-breaker makes page boundaries deterministic.
SELECT id, user_id, ordered_at, status
FROM orders
ORDER BY ordered_at DESC, id DESC
LIMIT 10;

-- 6. IMPORTANT RULES
-- LIMIT without ORDER BY returns an arbitrary subset, not reliably the first rows.
-- Large OFFSET values can be slow because skipped rows still must be found/read.
-- Concurrent inserts/deletes can shift offset-based pages between requests.
-- Keyset pagination can be more stable and efficient: filter using the last seen sort key.

-- 7. COMMON MISTAKES
-- Never use LIMIT as a substitute for a logically correct filter.
-- Avoid page-number pagination on a changing large table when consistency matters.

-- 8. INTERVIEW NOTES
-- Expect a comparison of OFFSET pagination and keyset/cursor pagination, including
-- ordering, index design, and concurrent-write behavior.

-- 9. PRACTICE TASKS (no solutions)
-- Level 1: Return the five lowest-priced active products.
-- Level 2: Return page three of users ordered by id, with four users per page.
-- Level 3: Write the next-page predicate for orders sorted by ordered_at and id descending.
-- Level 4: Propose an index and cursor token for a large, continuously updated feed.