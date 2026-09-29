-- ============================================
-- INTERVIEW QUESTIONS: subqueries, EXISTS, and CTEs
-- ============================================

-- CONCEPT CHECKS
-- 1. Scalar subquery vs set-returning subquery?
-- 2. EXISTS vs IN? What if an IN subquery contains NULL?
-- 3. What makes a subquery correlated?
-- 4. Are CTEs always materialized in PostgreSQL 16?
-- 5. How do you prevent cycles in a recursive CTE?

-- TASKS (no solutions)
-- Level 1: Find products more expensive than their category average.
-- Level 2: Find users who have never had a delivered order using NOT EXISTS.
-- Level 3: Use CTE stages to calculate one row per order then one row per customer.
-- Level 4: Traverse the employee manager tree and return each employee's root manager.

-- COMPLEX INTERVIEW CHALLENGES (no solutions)
-- 1. Find customers who purchased every product in the Accessories category (relational
--    division); clarify whether cancelled orders count.
-- 2. Identify products whose monthly delivered revenue increased for three consecutive
--    observed months; decide how months with no orders are represented.
-- 3. Find each employee's department percentile salary and list employees above their
--    department's 90th percentile without hard-coding department ids.
-- 4. Return customers whose latest order is later than every order of at least one
--    other customer; state tie and empty-set semantics.
