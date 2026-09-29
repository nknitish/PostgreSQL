-- ============================================
-- NULL: represent missing or unknown information
-- ============================================

-- 1. CONCEPT
-- NULL is a marker for absent/unknown/not-applicable data, not a value such as 0
-- or an empty string. SQL predicates use TRUE, FALSE, and UNKNOWN.

-- 2. WHY IT IS USED
-- Some attributes are genuinely optional or not yet known. NULL preserves that
-- distinction instead of inventing a fake value.

-- 3. BASIC EXAMPLES
SELECT id, name
FROM users
WHERE age IS NULL;

SELECT id, name, city
FROM users
WHERE city IS NOT NULL;

-- COALESCE returns the first non-NULL argument.
SELECT name, COALESCE(city, 'Unknown city') AS city_label
FROM users;

-- NULLIF returns NULL when two expressions are equal.
SELECT NULLIF(0, 0) AS missing_ratio_denominator;

-- 4. IMPORTANT RULES
-- Comparisons with NULL produce UNKNOWN; use IS NULL / IS NOT NULL.
-- WHERE and JOIN conditions keep only TRUE. CHECK constraints pass on TRUE or NULL.
-- COUNT(*) counts rows; COUNT(column) ignores NULL values.
-- PostgreSQL UNIQUE constraints allow multiple NULLs by default; PostgreSQL 15+
-- supports UNIQUE NULLS NOT DISTINCT when NULLs should conflict.
-- NULLS FIRST/LAST controls NULL placement in ORDER BY.

-- 5. COMMON MISTAKES
-- WRONG: WHERE age = NULL;
-- CORRECT: WHERE age IS NULL;
-- WRONG: COALESCE(age, 0) without considering whether zero is a valid age.

-- 6. INTERVIEW NOTES
-- Explain three-valued logic, NULL propagation, aggregate behavior, and NOT IN's
-- NULL trap. Distinguish an unknown value from a known empty string.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Find users with no city recorded.
-- Level 2: Count users with known ages and compare with total users.
-- Level 3: Find users not in Delhi while including unknown cities.
-- Level 4: Decide which fields in an order workflow may be NULL and document meaning.
