-- ============================================
-- INTERVIEW QUESTIONS: fundamentals and filtering
-- ============================================

-- Use the shared dataset. State the required output grain before writing SQL.

-- CONCEPT CHECKS (answer in your own words)
-- 1. Why is row order undefined without ORDER BY?
-- 2. What is the difference between WHERE and a SELECT-list alias?
-- 3. What does NULL mean, and why is `= NULL` incorrect?
-- 4. What do %, _, LIKE, and PostgreSQL ILIKE mean?
-- 5. Why can LIMIT/OFFSET pagination be unstable under concurrent writes?

-- SET OPERATIONS: UNION vs UNION ALL
-- UNION combines compatible result sets and removes duplicate output rows.
-- UNION ALL appends all rows and preserves duplicates; it is usually cheaper.
-- Both queries must return the same number of columns with compatible types.
-- The final ORDER BY applies to the combined result.

SELECT city AS location
FROM users
WHERE city IS NOT NULL
UNION
SELECT location
FROM departments
ORDER BY location;

-- 1. BASIC TASKS (no solutions)
-- Level 1: Return active users from Bangalore, ordered by name.
-- Level 2: Return the newest five orders with deterministic tie-breaking.
-- Level 3: Find users with missing city or age, labeling which field is missing.
-- Level 4: Combine customer and department locations with UNION, then compare row counts
--          with UNION ALL and explain which duplicates were removed.

-- 2. COMPLEX INTERVIEW CHALLENGES (no solutions)
-- 1. Find each user's longest consecutive gap between order dates; include users with
--    fewer than two orders and define the expected output for them.
-- 2. Return the 10 most recently active customers, where activity means either account
--    creation or an order; include a deterministic tie-breaker.
-- 3. Given a nullable status filter parameter, return all orders when it is NULL and
--    only matching orders otherwise, while keeping the predicate index-friendly.
