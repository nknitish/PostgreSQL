-- ============================================
-- EXPLAIN: inspect PostgreSQL's planned execution
-- ============================================

-- 1. CONCEPT
-- EXPLAIN displays the planner's chosen plan without running the query.
-- EXPLAIN ANALYZE executes it and reports actual row counts/timing alongside estimates.

-- 2. WHY IT IS USED
-- It helps find scans, join strategies, row-estimate errors, sorting, and buffer work.

-- 3. BASIC EXAMPLES
EXPLAIN
SELECT id, user_id, ordered_at
FROM orders
WHERE user_id = 1
ORDER BY ordered_at DESC, id DESC
LIMIT 5;

-- ANALYZE executes the SELECT. It is read-only here, but can still be expensive.
EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT id, user_id, ordered_at
FROM orders
WHERE user_id = 1
ORDER BY ordered_at DESC, id DESC
LIMIT 5;

-- 4. IMPORTANT RULES
-- Compare estimated rows with actual rows; large differences can cause bad choices.
-- BUFFERS reports shared/local/temp block activity, not elapsed-time alone.
-- Tiny practice tables often correctly use sequential scans even when indexed.
-- EXPLAIN ANALYZE on INSERT/UPDATE/DELETE executes the mutation; wrap carefully in
-- BEGIN/ROLLBACK only when the statement's effects are safe to reverse.

-- 5. COMMON MISTAKES
-- Treating cost as milliseconds, or assuming an index scan is always better.
-- Benchmarking once on warm cache and generalizing to production workload.

-- 6. INTERVIEW NOTES
-- Read plan nodes bottom-up: identify scan inputs, join conditions, row estimates,
-- loops, sort/hash work, and actual versus estimated cardinality.

-- 7. PRACTICE TASKS (no solutions)
-- Level 1: Explain a user lookup by primary key.
-- Level 2: Compare plans before and after a relevant index on a larger data set.
-- Level 3: Diagnose a nested-loop plan with unexpectedly high loop counts.
-- Level 4: Use BUFFERS and row-estimate evidence to propose one targeted change.
