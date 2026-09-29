-- ============================================
-- INTERVIEW QUESTIONS: advanced PostgreSQL query patterns
-- ============================================

-- CONCEPT CHECKS
-- 1. How do transaction isolation and MVCC affect concurrent readers/writers?
-- 2. What does EXPLAIN ANALYZE execute, and what evidence should you inspect?
-- 3. When can a composite B-tree index support a filter and ordering?
-- 4. What is the difference between JSON null, a missing JSON key, and SQL NULL?
-- 5. Why are check-then-insert and application-only uniqueness checks unsafe?

-- CHALLENGES (no solutions; define assumptions before implementation)
-- 1. Top customers by delivered revenue per month, include ties, and return the top
--    three months per customer. Ensure order line totals are not duplicated.
-- 2. Calculate customer retention by signup cohort: a user is retained in a month if
--    they place at least one non-cancelled order that month. Include zero-activity months.
-- 3. Find the longest consecutive daily ordering streak per customer; return every
--    customer, including those with no orders, and define their streak result.
-- 4. Return products that were never sold at their current list price, comparing the
--    historical order_items.unit_price snapshot with products.list_price.
-- 5. Design an idempotent order-ingestion transaction using a unique external key,
--    ON CONFLICT, RETURNING, and a retry-safe response.

-- PERFORMANCE EXERCISE
-- Choose one challenge above, load a larger generated dataset, capture EXPLAIN
-- (ANALYZE, BUFFERS), identify the expensive node, and justify one measured change.
-- Do not add indexes based only on intuition; record read benefit and write cost.
