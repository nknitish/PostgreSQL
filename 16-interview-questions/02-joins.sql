-- ============================================
-- INTERVIEW QUESTIONS: joins and relational grain
-- ============================================

-- CONCEPT CHECKS
-- 1. INNER JOIN vs LEFT JOIN: which side's unmatched rows survive?
-- 2. Why can COUNT(*) be wrong for a LEFT JOIN with no children?
-- 3. How can WHERE on the nullable side effectively undo a LEFT JOIN?
-- 4. What is fan-out, and how can two one-to-many joins inflate SUM?
-- 5. When is EXISTS preferable to joining and deduplicating?

-- TASKS (no solutions)
-- Level 1: Return all departments and their employee counts, including zero.
-- Level 2: Return all users and their delivered-order counts, including zero.
-- Level 3: Find users who ordered a product from every active category.
-- Level 4: Reconcile users and orders so each user is labeled as no orders, only
--          cancelled orders, or at least one non-cancelled order.

-- COMPLEX INTERVIEW CHALLENGES (no solutions)
-- 1. Calculate delivered revenue per customer and per product in one report without
--    multiplying either measure. Include customers with zero delivered revenue.
-- 2. Find customers whose latest order contains at least three distinct products;
--    specify tie behavior for equal order timestamps.
-- 3. Return departments where every employee earns above the company median salary,
--    while deciding how empty departments should be treated.
-- 4. For each user, report the latest non-cancelled order and the immediately prior
--    non-cancelled order, preserving users with no qualifying orders.
