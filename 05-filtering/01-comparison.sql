-- ============================================
-- COMPARISON OPERATORS: compare scalar values
-- ============================================

-- 1. CONCEPT
-- Comparison operators evaluate relationships between values: =, <>, <, <=, >, >=.
-- PostgreSQL also accepts != as an alternative spelling of <>.

-- 2. WHY IT IS USED
-- Comparisons express eligibility, ranges, ordering boundaries, and join predicates.

-- 3. BASIC EXAMPLES
SELECT id, name, age
FROM users
WHERE age >= 30;

SELECT id, product_name, list_price
FROM products
WHERE list_price <> 0;

-- 4. PRACTICAL EXAMPLE
SELECT id, ordered_at, status
FROM orders
WHERE ordered_at >= TIMESTAMP '2025-03-01 00:00:00'
	AND ordered_at <  TIMESTAMP '2025-04-01 00:00:00';

-- Half-open time ranges include the start and exclude the next boundary, avoiding
-- assumptions about fractional-second precision on the final day.

-- 5. IMPORTANT RULES
-- NULL comparisons are UNKNOWN, not TRUE/FALSE. Use IS NULL and IS NOT NULL.
-- Ensure compared values have compatible types; explicit typed literals can clarify intent.
-- BETWEEN is inclusive at both ends; see 05-filtering/04-between.sql.

-- 6. COMMON MISTAKES
-- WRONG: WHERE city <> 'Delhi' omits NULL cities because result is UNKNOWN.
-- If unknown cities should be included, add `OR city IS NULL`.

-- 7. INTERVIEW NOTES
-- Clarify inclusive/exclusive boundaries and how timestamp filters interact with time zones.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Find users aged at least 30.
-- Level 2: Find orders in March 2025 using a half-open timestamp range.
-- Level 3: Find products priced above their category's average (subquery required).
-- Level 4: Define a correct time predicate for one local calendar day across DST changes.
