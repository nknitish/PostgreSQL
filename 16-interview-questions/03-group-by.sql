-- ============================================
-- INTERVIEW QUESTIONS: grouping and aggregates
-- ============================================

-- CONCEPT CHECKS
-- 1. WHERE vs HAVING: at what logical stage does each filter apply?
-- 2. COUNT(*) vs COUNT(column)?
-- 3. Why does GROUP BY sometimes allow selecting columns functionally dependent on a PK?
-- 4. What does AVG do with NULL values?
-- 5. How can join fan-out inflate an aggregate?

-- TASKS (no solutions)
-- Level 1: Count users per city, including NULL city.
-- Level 2: Find departments with at least two employees and average salary over 100000.
-- Level 3: Compute delivered revenue per customer by month and keep months over 500.
-- Level 4: Include zero-order customers in a revenue report without turning NULL into
--          a misleading value before deciding the business meaning.

-- COMPLEX INTERVIEW CHALLENGES (no solutions)
-- 1. Find customers whose rolling 90-day delivered spend exceeds the overall customer
--    median rolling spend at any point in the last six months.
-- 2. For each month, calculate new customers, repeat customers, and revenue from each
--    cohort; define month boundaries and cohort membership precisely.
-- 3. Return the top three products by delivered revenue per category, including ties,
--    and exclude categories with no delivered sales.
-- 4. Calculate conversion from users to first delivered order by signup month while
--    avoiding duplicated users and line-item multiplication.
