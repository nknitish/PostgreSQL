-- ============================================
-- INTERVIEW QUESTIONS: window functions
-- ============================================

-- CONCEPT CHECKS
-- 1. Window function vs GROUP BY?
-- 2. ROW_NUMBER vs RANK vs DENSE_RANK?
-- 3. PARTITION BY vs GROUP BY?
-- 4. What is the default frame when ORDER BY is present, and why use ROWS explicitly?
-- 5. Why can LAG(revenue) mean previous observed month rather than previous calendar month?

-- TASKS (no solutions)
-- Level 1: Return each employee with rank and dense rank by salary per department.
-- Level 2: Return the top two distinct salary levels in each department, including ties.
-- Level 3: Compute a running delivered total per customer with stable ordering.
-- Level 4: Find each user's longest streak of consecutive calendar months with an order.

-- COMPLEX INTERVIEW CHALLENGES (no solutions)
-- 1. For each product, calculate a 3-month moving average of monthly delivered quantity,
--    including missing months as zero and excluding future periods.
-- 2. Detect customers whose monthly spend grew for at least four consecutive months;
--    define whether zero-spend months break the streak.
-- 3. Find the second distinct highest salary per department, returning all tied employees
--    and departments with fewer than two distinct salaries appropriately.
-- 4. Sessionize user events when the gap between consecutive events exceeds 30 minutes;
--    describe which timestamp ties share a session boundary.
