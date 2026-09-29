-- ============================================
-- INDEXES: trade write/storage cost for read access paths
-- ============================================

-- 1. CONCEPT
-- An index is a separate data structure PostgreSQL may use to find rows without
-- scanning the whole table. It does not guarantee a faster plan.

-- 2. WHY IT IS USED
-- Indexes can accelerate selective filters, joins, ordering, and constraint checks.

-- 3. BASIC SYNTAX
CREATE INDEX orders_user_ordered_at_idx
	ON orders (user_id, ordered_at DESC);

-- 4. PRACTICAL EXAMPLES
-- A unique index can enforce a case-insensitive key:
CREATE UNIQUE INDEX users_email_lower_uidx
	ON users (LOWER(email));

-- Partial index: only index rows frequently queried as pending.
CREATE INDEX orders_pending_by_date_idx
	ON orders (ordered_at, id)
	WHERE status = 'pending';

-- 5. IMPORTANT RULES
-- Indexes consume storage and add write, vacuum, and maintenance cost.
-- PostgreSQL may choose a sequential scan when it estimates that scanning is cheaper.
-- B-tree is the default and supports equality/range/order patterns; GIN, GiST, BRIN,
-- and hash serve different workloads.
-- Primary/unique constraints create indexes. A foreign key does not create a child index.

-- 6. COMMON MISTAKES
-- Indexing every column; duplicating an existing composite index prefix without evidence;
-- assuming an index is used because a predicate mentions its column.

-- 7. INTERVIEW NOTES
-- Explain selectivity, statistics, index-only scans/visibility map, write amplification,
-- and how EXPLAIN verifies planner choices.

-- 8. PRACTICE TASKS (no solutions)
-- Level 1: Index orders by user_id for customer history lookup.
-- Level 2: Propose an index for pending orders ordered by time.
-- Level 3: Check whether the index helps a real query with EXPLAIN (ANALYZE, BUFFERS).
-- Level 4: Compare B-tree, GIN, GiST, and BRIN for a workload you can describe.

-- Cleanup after experiments, if needed:
-- DROP INDEX IF EXISTS orders_user_ordered_at_idx;
