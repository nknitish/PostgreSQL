-- ============================================
-- BETWEEN: filter within an inclusive range
-- ============================================

-- 1. CONCEPT
-- x BETWEEN low AND high is equivalent to x >= low AND x <= high.

-- 2. WHY IT IS USED
-- It makes numeric, date, and ordered-value ranges easy to read.

-- 3. BASIC EXAMPLES
SELECT id, name, age
FROM users
WHERE age BETWEEN 25 AND 30;

SELECT id, ordered_at
FROM orders
WHERE ordered_at BETWEEN TIMESTAMP '2025-01-01 00:00:00'
											AND TIMESTAMP '2025-01-31 23:59:59';

-- Prefer a half-open interval for timestamps so fractional seconds are included:
SELECT id, ordered_at
FROM orders
WHERE ordered_at >= TIMESTAMP '2025-01-01 00:00:00'
	AND ordered_at <  TIMESTAMP '2025-02-01 00:00:00';

-- 4. IMPORTANT RULES
-- Both boundaries are included. If x or a boundary is NULL, the result may be UNKNOWN.
-- BETWEEN SYMMETRIC is a PostgreSQL extension that accepts reversed bounds.

-- 5. COMMON MISTAKES
-- Timestamp upper bounds ending at 23:59:59 can miss fractional-second values.
-- Use the start of the next interval as the exclusive upper bound instead.

-- 6. INTERVIEW NOTES
-- State whether range endpoints are inclusive and explain safe time-window boundaries.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Find users aged 26 through 32 inclusive.
-- Level 2: Find orders created during February 2025 with a half-open range.
-- Level 3: Find products in a price band while excluding inactive products.
